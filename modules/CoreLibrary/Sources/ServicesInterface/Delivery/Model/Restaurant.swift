import Foundation

public struct Restaurant: Decodable {
    public let name: String
    public let category: String
    public let deliveryTime: RestaurantDeliveryTime

    public enum CodingKeys: String, CodingKey {
        case name, category
        case deliveryTime = "delivery_time"
    }
    
    public init(name: String, category: String, deliveryTime: RestaurantDeliveryTime) {
        self.name = name
        self.category = category
        self.deliveryTime = deliveryTime
    }
}

extension Restaurant: Identifiable {
    public var id: String {
        "\(name)"
    }
}

extension Restaurant: Equatable {
    public static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.name.caseInsensitiveCompare(rhs.name) == .orderedSame
    }
}
