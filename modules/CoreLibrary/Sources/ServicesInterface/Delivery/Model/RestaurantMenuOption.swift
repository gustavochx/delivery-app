import Foundation

public struct RestaurantMenuOption: Decodable, Identifiable {
    public var id: String {
        name
    }
    
    public let category: String
    public let name: String
    public let price: Int
    
    public var formattedPrice: String {
        price.formatted(.currency(code: "BRL"))
    }
}
