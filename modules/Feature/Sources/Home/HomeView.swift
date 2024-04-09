import Navigation
import RestaurantsInterface
import SwiftUI
import SwiftUIFoundations
import UIKit

struct HomeView: View {
    @StateObject var viewModel: HomeViewModel

    init(viewModel: HomeViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        NavigationView {
            contentView
                .navigationDestination(for: $viewModel.state.route, destination: { route in
                    switch route {
                    case let .restaurant(homeRoute):
                        ViewFromRoute(
                            route: homeRoute,
                            navigationService: viewModel.environment.appNavigator,
                            bindings: RestaurantDetailsBindings(
                                deliveryClient: viewModel.environment.deliveryClient,
                                delegate: nil,
                                onTapSomething: {
                                    viewModel.someAction()
                                }
                            )
                        )
                    }
                })
        }
        .navigationViewStyle(.stack)
        .navigationTitle("Delivery App")
    }

    var restaurantListView: some View {
        VStack {
            ForEach(viewModel.state.restaurants, id: \.name) { restaurant in
                RestaurantRowView(restaurant: restaurant) {
                    viewModel.selectRestaurant(restaurant)
                }
            }
        }
        .padding([.top, .horizontal], 16.0)
        .onAppear {
            viewModel.loadRestaurants()
        }
    }


    var contentView: some View {
        VStack {
            restaurantListView
            Spacer()
        }
    }
}
