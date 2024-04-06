import SwiftUI
import Services
import ServicesInterface

struct RestaurantDetailsHeaderViewModel {
    let restaurantDetail: RestaurantDetail?

    var restaurantName: String {
        restaurantDetail?.name ?? ""
    }

    var restaurantType: String {
        restaurantDetail?.category ?? ""
    }

    var restaurantDeliveryTime: String {
        guard let deliveryTime = restaurantDetail?.deliveryTime else { return "" }
        return "\(deliveryTime.min)-\(deliveryTime.max)"
    }

    var restaurantScore: String {
        "\(restaurantDetail?.reviews.score ?? 0)"
    }

    var restaurantValuationCount: String {
        "\(restaurantDetail?.reviews.count ?? 0) avaliações"
    }
}

struct RestaurantDetailsHeaderView: View {
    var viewModel: RestaurantDetailsHeaderViewModel

    var body: some View {
        VStack {
            HStack {
                restaurantInformationView
                Spacer()
                restaurantImageView
            }
            restaurantValuationView
        }
        .padding(.horizontal, 16.0)
    }

    var restaurantImageView: some View {
        Image("restaurant-logo")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 80.0, height: 80.0)
            .background(Color.gray)
            .clipShape(Circle())
    }

    var restaurantInformationView: some View {
        VStack(alignment: .leading, spacing: 16.0) {
            Text(viewModel.restaurantName)
                .font(.system(size: 16.0, weight: .bold))
            restaurantTypeAndDeliveryView
        }
    }

    var restaurantTypeAndDeliveryView: some View {
        HStack(spacing: 16.0) {
            Text(viewModel.restaurantType)
                .font(.system(size: 12.0, weight: .regular))
            Text(viewModel.restaurantDeliveryTime)
                .font(.system(size: 12.0, weight: .regular))
        }
    }

    var restaurantValuationView: some View {
        HStack {
            Text(viewModel.restaurantScore)
                .font(.system(size: 14.0))
            Spacer()
            Text(viewModel.restaurantValuationCount)
                .font(.system(size: 10, weight: .regular))
                .foregroundStyle(.gray)
        }
    }
}

#Preview {
    RestaurantDetailsHeaderView(
        viewModel: .init(restaurantDetail: RestaurantDetail.fixture)
    )
}
