import SwiftUI
import ServicesInterface

// TODO: Discuss with Bocato what should be the best approach:
/// 1 - Create a viewModel for the component
/// 2 - Or simple store the needed attributes directly on the component
struct RestaurantRowView: View {
    private let restaurant: Restaurant
    private let action: () -> Void
    
    init(
        restaurant: Restaurant,
        action: @escaping () -> Void
    ) {
        self.restaurant = restaurant
        self.action = action
    }
    
    var restaurantDeliveryTimeText: String {
        "\(restaurant.deliveryTime.min) - \(restaurant.deliveryTime.max) mins"
    }
    
    var body: some View {
        HStack {
            restaurantImageView
            restaurantTitleDetailsView
            Spacer()
            disclosureView
        }
        .onTapGesture {
            action()
        }
    }
    
    var restaurantImageView: some View {
        Image("restaurant-logo")
            .resizable()
            .frame(width: 45.0, height: 45.0)
            .clipShape(Circle())
    }
    
    var restaurantTitleDetailsView: some View {
        VStack(alignment: .leading) {
            Text(restaurant.name)
            HStack(alignment: .firstTextBaseline) {
                Text(restaurant.category)
                Text(restaurantDeliveryTimeText)
            }
        }
    }
    
    var disclosureView: some View {
        Image(systemName: "chevron.right")
            .font(.body)
    }
}

struct RestaurantRowView_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantRowView(
            restaurant: .init(
                name: "",
                category: "",
                deliveryTime: .init(
                    min: 10,
                    max: 15
                )
            ),
            action: {}
        )
    }
}
