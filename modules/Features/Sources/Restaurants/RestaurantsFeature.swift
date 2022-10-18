import Foundation
import Navigation
import RestaurantsInterface

public enum RestaurantsFeature {
    public static func bootstrap() {
        try? RouterService
            .shared
            .registerFactory(
                factory: { _ in
                    return RestaurantDetailsViewController()
                }, for: RestaurantDetailsRoute.self
            )
    }
}
