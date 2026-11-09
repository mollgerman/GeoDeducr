import SwiftUI

extension Font {
    static let gdLogo       = Font.custom("LuckiestGuy-Regular", size: 52)
    static let gdLargeTitle = Font.custom("Nunito-Black",     size: 34, relativeTo: .largeTitle)
    static let gdTitle1     = Font.custom("Nunito-ExtraBold", size: 28, relativeTo: .title)
    static let gdTitle3     = Font.custom("Nunito-ExtraBold", size: 20, relativeTo: .title3)
    static let gdHeadline   = Font.custom("Nunito-ExtraBold", size: 17, relativeTo: .headline)
    static let gdBody       = Font.custom("Nunito-SemiBold",  size: 17, relativeTo: .body)
    static let gdCaption    = Font.custom("Nunito-ExtraBold", size: 12, relativeTo: .caption)
}
