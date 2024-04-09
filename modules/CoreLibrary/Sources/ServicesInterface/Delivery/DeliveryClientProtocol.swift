import Foundation
import Dependencies
import XCTestDynamicOverlay

// sourcery: swiftDepAutoregister
public protocol DeliveryClientProtocol {
    func fetchRestaurant(_ completion: @escaping ([Restaurant]) -> Void)
    func fetchRestaurantDetail(restaurantName: String, completion: @escaping (RestaurantDetail?) -> Void)
}

public enum DeliveryClientDependencyKey: TestDependencyKey {
    public static var testValue: DeliveryClientProtocol {
        #if DEBUG
        return DeliveryClientFailing()
        #else
        fatalError("`testValue` should not be acessed on non DEBUG builds.")
        #endif
    }
}

public extension DependencyValues {
    var deliveryClient: DeliveryClientProtocol {
        get { self[DeliveryClientDependencyKey.self] }
        set { self[DeliveryClientDependencyKey.self] = newValue }
    }
}

#if DEBUG
public struct DeliveryClientFailing: DeliveryClientProtocol {
    init() {}
    
    public func fetchRestaurant(_ completion: @escaping ([Restaurant]) -> Void) {
        XCTFail("\(#function) should not be called")
    }
    
    public func fetchRestaurantDetail(restaurantName: String, completion: @escaping (RestaurantDetail?) -> Void) {
        XCTFail("\(#function) should not be called")
    }
}
#endif
