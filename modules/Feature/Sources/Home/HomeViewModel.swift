import Foundation
import SwiftUI
import RestaurantsInterface
import ServicesInterface
import Navigation

public enum HomeStartSource: Equatable {
    case appStart
    case deepLink(URL)
}

struct HomeState: Equatable {
    var startSource: HomeStartSource
    var restaurants: [Restaurant] = []
    var route: Route?

    enum Route: Equatable, Hashable {
        func hash(into hasher: inout Hasher) {
            hasher.combine(self)
        }

        case restaurant(RestaurantDetailsRoute)
    }
}

struct HomeEnvironment {
    let deliveryClient: DeliveryClientProtocol
    let appNavigator: AppNavigator
}

final class HomeViewModel: ObservableObject {
    @Published var state: HomeState
    private(set) var environment: HomeEnvironment

    init(
        initialState: HomeState,
        environment: HomeEnvironment
    ) {
        self.state = initialState
        self.environment = environment
    }

    func loadRestaurants() {
        environment.deliveryClient.fetchRestaurant { [weak self] restaurants in
            self?.state.restaurants = restaurants
        }
    }

    func selectRestaurant(_ restaurant: Restaurant) {
        let detailsRoute = RestaurantDetailsRoute(
            restaurant: restaurant,
            deliveryClient: environment.deliveryClient
        )
        state.route = .restaurant(detailsRoute)
    }

    func someAction() {
        print("Some Action")
    }
}
