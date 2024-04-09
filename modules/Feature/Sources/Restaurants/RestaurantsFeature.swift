import DependencyInjection
import Foundation
import Navigation
import RestaurantsInterface
import ServicesInterface
import Dependencies
import SwiftUI

public enum RestaurantFeature {
    struct Dependencies {
        @Dependency(\.navigationService) var navigationService
        @Dependency(\.deliveryClient) var deliveryClient
    }

    static var dependencies: Dependencies = .init()

    public static func bootstrap() {
        let navigationService = dependencies.navigationService
        try? navigationService.registerFactory(
            factory: { route, bindings in
                guard
                    let route = route as? RestaurantDetailsRoute
                else {
                    preconditionFailure("Expected HomeRoute")
                }
                
                let viewModel = RestaurantDetailsViewModel(
                    initialState: .init(restaurant: route.restaurantInputs.restaurant),
                    environment: .init(deliveryClient: dependencies.deliveryClient)
                )
                return UIHostingController(rootView: RestaurantDetailsView(viewModel: viewModel))
            },
            for: RestaurantDetailsRoute.self
        )
    }
}
