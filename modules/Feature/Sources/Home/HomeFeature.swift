import DependencyInjection
import Foundation
import Navigation
import ServicesInterface
import Dependencies
import SwiftUI

public enum HomeFeature {
    struct Dependencies {
        @Dependency(\.navigationService) var navigationService: NavigationService
        @Dependency(\.deliveryClient) var deliveryClient: DeliveryClientProtocol
    }

    static var dependencies: Dependencies = .init()

    public static func bootstrap() {
        let navigationService = dependencies.navigationService
        try? navigationService.registerFactory(
            factory: { route, _ in
                guard
                    let route = route as? HomeRoute
                else {
                    preconditionFailure("Expected HomeRoute")
                }
                let homeViewModel = HomeViewModel(
                    initialState: .init(
                        startSource: route.source
                    ),
                    environment: .init(
                        deliveryClient: dependencies.deliveryClient,
                        appNavigator: dependencies.navigationService
                    )
                )
                return UIHostingController(rootView: HomeView(viewModel: homeViewModel))
            },
            for: HomeRoute.self
        )
    }
}
