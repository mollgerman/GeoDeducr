import Foundation
import MapKit
import OSLog

/// Loads the country borders from countries.geojson with Apple's MKGeoJSONDecoder.
struct CountryService {
    enum LoadError: Error {
        case fileNotFound
    }

    /// The only properties we read from each GeoJSON feature (Natural Earth uses upper-case keys).
    private struct Properties: Decodable {
        let name: String
        let labelX: Double   // longitude of the label
        let labelY: Double   // latitude of the label
        let labelRank: Int

        enum CodingKeys: String, CodingKey {
            case name = "NAME"
            case labelX = "LABEL_X"
            case labelY = "LABEL_Y"
            case labelRank = "LABELRANK"
        }
    }

    func loadCountries() throws -> [Country] {
        guard let url = Bundle.main.url(forResource: "countries", withExtension: "geojson") else {
            Logger.map.error("countries.geojson is missing from the app bundle")
            throw LoadError.fileNotFound
        }

        let data = try Data(contentsOf: url)
        let objects = try MKGeoJSONDecoder().decode(data)
        let features = objects.compactMap { $0 as? MKGeoJSONFeature }
        let countries = features.compactMap { makeCountry(from: $0) }

        Logger.map.info("Loaded \(countries.count) country outlines")
        return countries
    }

    /// Turns one GeoJSON feature into a Country, or nil if its data is incomplete.
    private func makeCountry(from feature: MKGeoJSONFeature) -> Country? {
        guard let propertiesData = feature.properties,
              let properties = try? JSONDecoder().decode(Properties.self, from: propertiesData)
        else { return nil }

        // A country is one polygon, or several (e.g. mainland + islands) in a multipolygon
        var outlines: [[CLLocationCoordinate2D]] = []
        for geometry in feature.geometry {
            if let polygon = geometry as? MKPolygon {
                outlines.append(polygon.coordinateList)
            } else if let multiPolygon = geometry as? MKMultiPolygon {
                outlines += multiPolygon.polygons.map { $0.coordinateList }
            }
        }

        return Country(
            id: properties.name,
            name: properties.name,
            labelCoordinate: CLLocationCoordinate2D(latitude: properties.labelY, longitude: properties.labelX),
            labelRank: properties.labelRank,
            outlines: outlines
        )
    }
}

private extension MKPolygon {
    /// MapKit stores a polygon's points as map points; MapPolygon needs coordinates.
    var coordinateList: [CLLocationCoordinate2D] {
        let mapPoints = points()
        return (0..<pointCount).map { mapPoints[$0].coordinate }
    }
}
