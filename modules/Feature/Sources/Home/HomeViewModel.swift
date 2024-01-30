import Foundation
import SwiftUI
import Restaurants
import ServicesInterface

public enum HomeStartSource {
    case appStart
    case deepLink(URL)
}

struct HomeState: Equatable {
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
