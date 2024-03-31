import Foundation
import Navigation
import ServicesInterface

public struct RestaurantDetailsRoute: Route, Equatable {
    public static var identifier: RouterIdentifier {
        "RestaurantDetails"
    }
    
    public let restaurantInputs: RestaurantDetailsInputs

    public init(
        restaurant: Restaurant,
        deliveryClient: DeliveryClientProtocol
    ) {
        self.restaurantInputs = RestaurantDetailsInputs(restaurant: restaurant)
    }
}

public struct RestaurantDetailsInputs: Equatable {
    public let restaurant: Restaurant
}

public struct RestaurantDetailsBindings {
    public let onTapSomething: () -> Void
    public let deliveryClient: DeliveryClientProtocol
    public let delegate: RestaurantActionsDelegate?
    
    public init(
        deliveryClient: DeliveryClientProtocol,
        delegate: RestaurantActionsDelegate?,
        onTapSomething: @escaping () -> Void
    ) {
        self.deliveryClient = deliveryClient
        self.delegate = delegate
        self.onTapSomething = onTapSomething
    }
}

public protocol RestaurantActionsDelegate: AnyObject {
    func didFinishLoading()
    func errorOnLoading()
}
