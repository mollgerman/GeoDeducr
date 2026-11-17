import SwiftUI

extension Font {
    static let gdLogo       = Font.custom("LuckiestGuy-Regular", size: 52)
    static let gdLargeTitle = Font.custom("Nunito-Black",     size: 34, relativeTo: .largeTitle)
    static let gdTitle1     = Font.custom("Nunito-ExtraBold", size: 28, relativeTo: .title)
    static let gdTitle2     = Font.custom("Nunito-ExtraBold", size: 22, relativeTo: .title2)
    static let gdTitle3     = Font.custom("Nunito-ExtraBold", size: 20, relativeTo: .title3)
    static let gdHeadline   = Font.custom("Nunito-ExtraBold", size: 17, relativeTo: .headline)
    static let gdBody       = Font.custom("Nunito-SemiBold",  size: 17, relativeTo: .body)
    static let gdCallout    = Font.custom("Nunito-SemiBold",  size: 16, relativeTo: .callout)
    static let gdSubheadline = Font.custom("Nunito-Bold",      size: 15, relativeTo: .subheadline)
    static let gdFootnote   = Font.custom("Nunito-Bold",  size: 13, relativeTo: .footnote)
    static let gdCaption    = Font.custom("Nunito-ExtraBold", size: 12, relativeTo: .caption)
}
