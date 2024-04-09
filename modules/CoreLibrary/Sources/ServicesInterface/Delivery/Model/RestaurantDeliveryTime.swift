import Foundation

public struct RestaurantDeliveryTime: Decodable {
    public let min: Int
    public let max: Int
    
    public init(min: Int, max: Int) {
        self.min = min
        self.max = max
    }
}
