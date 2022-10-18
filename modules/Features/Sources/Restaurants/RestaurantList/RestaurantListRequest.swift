import Foundation
import Networking

struct RestaurantListRequest: NetworkRequest {
    var baseURL: String  { "https://raw.githubusercontent.com/devpass-tech/challenge-delivery-app/main/api/" }
    var pathURL = "home_restaurant_list.json"
    var method: HTTPMethod = .get
}
