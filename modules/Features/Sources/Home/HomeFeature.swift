import Foundation
import Navigation

public struct HomeRoute: Route {
    public static var identifier: Navigation.RouterIdentifier {
        "HomeRoute"
    }
    
    public let presentationStyle: Navigation.PresentationStyle
    
    init(presentationStyle: Navigation.PresentationStyle) {
        self.presentationStyle = presentationStyle
    }
}

public enum RestaurantsFeature {
//    @Dependency static var deliveryApi: DeliveryApiProtocol
    public static func bootstrap() {
        try? RouterService
            .shared
            .registerFactory(
                factory: { _ in
                    return HomeViewController(
                        customView: HomeView(),
                        deliveryApi: DeliveryApiProtocol,
                        navigator: NavigatorProtocol
                    )
                }, for: HomeRoute.self
            )
    }
}
