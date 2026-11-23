import CoreLocation

/// One country's outline and name label, drawn on top of the satellite map.
/// Data: Natural Earth 1:110m country borders (public domain), Resources/countries.geojson.
struct Country: Identifiable {
    let id: String                              // the country name; unique in the file
    let name: String
    let labelCoordinate: CLLocationCoordinate2D // where the name is written
    let labelRank: Int                          // 2 = big, important country … 7 = tiny one
    let outlines: [[CLLocationCoordinate2D]]    // one list of border points per part (mainland, islands…)
}
