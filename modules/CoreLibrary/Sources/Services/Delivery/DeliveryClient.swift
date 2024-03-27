import DependencyInjection
import Foundation
import NetworkingInterface
import ServicesInterface
import Dependencies

public struct DeliveryClient: DeliveryClientProtocol {
    @Dependency(\.networkManager) var networkManager

    public init() {}

    public func fetchRestaurant(_ completion: @escaping ([Restaurant]) -> Void) {
        completion(Restaurant.fixture)
    }

    public func fetchRestaurantDetail(restaurantName _: String, completion: @escaping (RestaurantDetail?) -> Void) {
        completion(RestaurantDetail.fixture)
    }
}

extension DeliveryClientDependencyKey: DependencyKey {
    public static var liveValue: DeliveryClientProtocol {
        DeliveryClient()
    }
}
