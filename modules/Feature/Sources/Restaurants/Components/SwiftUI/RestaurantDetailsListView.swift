import SwiftUI
import ServicesInterface

struct RestaurantDetailsListViewModel {
    var restaurantDetail: RestaurantDetail?

    init(restaurantDetail: RestaurantDetail?) {
        self.restaurantDetail = restaurantDetail
    }

    var grouppedCategories: [String] {
        restaurantDetail?.grouppedCategories ?? []
    }

    func menuOptionsFor(category: String) -> [RestaurantMenuOption] {
        guard let restaurantDetail = restaurantDetail else { return [] }
        return restaurantDetail.menuOptionsFor(category: category)
    }
}

struct RestaurantDetailsListView: View {
    var viewModel: RestaurantDetailsListViewModel

    init(viewModel: RestaurantDetailsListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        List {
            ForEach(viewModel.grouppedCategories, id: \.self) { category in
                Section {
                    ForEach(viewModel.menuOptionsFor(category: category)) { menuOption in
                        RestaurantMealInformationView(
                            name: menuOption.name,
                            price: menuOption.formattedPrice
                        )
                    }
                } header: {
                    VStack(alignment: .leading) {
                        Text(category)
                            .font(.system(size: 18.0, weight: .bold))
                    }
                }
                .headerProminence(.increased)
            }
        }
        .listStyle(.plain)
    }
}

private struct RestaurantMealInformationView: View {
    var name: String
    var price: String

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6.0) {
                Text(name)
                    .font(.system(size: 14.0))
                Text(price)
                    .font(.system(size: 12))
                    .foregroundStyle(.gray)
            }
            Spacer()
            mealImageView
        }
    }

    var mealImageView: some View {
        Image("pizza")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: 60.0, height: 60.0)
            .background(Color.teal)
            .clipShape(Circle())
    }
}

#Preview {
    let restaurantDetails = RestaurantDetail.fixture
    let restaurantDetailsListViewModel = RestaurantDetailsListViewModel(restaurantDetail: restaurantDetails)
    return RestaurantDetailsListView(viewModel: restaurantDetailsListViewModel)
}
