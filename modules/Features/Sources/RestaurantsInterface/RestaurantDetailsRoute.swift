import Foundation
import Navigation

public struct RestaurantDetailsRoute: Route {
    public static var identifier: RouterIdentifier {
        "RestaurantDetails"
    }

    public let presentationStyle: PresentationStyle
    public init(presentationStyle: PresentationStyle) {
        self.presentationStyle = presentationStyle
    }
}
