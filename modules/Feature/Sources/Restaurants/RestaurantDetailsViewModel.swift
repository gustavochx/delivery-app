import Foundation
import Services
import ServicesInterface

struct RestaurantDetailsState {
    var restaurant: Restaurant
    var restaurantDetail: RestaurantDetail?
}

struct RestaurantDetailsEnvironment {
    let deliveryClient: DeliveryClientProtocol
}

@dynamicMemberLookup
final class RestaurantDetailsViewModel: ObservableObject {
    @Published var state: RestaurantDetailsState
    private let environment: RestaurantDetailsEnvironment

    init(
        initialState: RestaurantDetailsState,
        environment: RestaurantDetailsEnvironment
    ) {
        state = initialState
        self.environment = environment
    }

    func fetchRestaurant() {
        environment.deliveryClient.fetchRestaurantDetail(
            restaurantName: state.restaurant.name
        ) { [weak self] restaurantDetail in
            self?.state.restaurantDetail = restaurantDetail
        }
    }
}

extension RestaurantDetailsViewModel {
    subscript<T>(dynamicMember keyPath: KeyPath<RestaurantDetailsState, T>) -> T {
        state[keyPath: keyPath]
    }
}
