import SwiftUI
import Services
import ServicesInterface

struct RestaurantDetailsView: View {
    @StateObject var viewModel: RestaurantDetailsViewModel

    init(viewModel: RestaurantDetailsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack {
            RestaurantDetailsHeaderView(
                viewModel: .init(
                    restaurantDetail: viewModel.restaurantDetail
                )
            )
            RestaurantDetailsListView(
                viewModel: .init(
                    restaurantDetail: viewModel.restaurantDetail
                )
            )
        }
        .task {
            viewModel.fetchRestaurant()
        }
    }
}

#Preview {
    RestaurantDetailsView(
        viewModel: .init(
            initialState: .init(
                restaurant: Restaurant.fixture[0],
                restaurantDetail: RestaurantDetail.fixture
            ), 
            environment: .init(
                deliveryClient: DeliveryClient()
            )
        )
    )
}
