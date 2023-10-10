import UIKit
import SwiftUI
import Navigation
import ServicesInterface
import Restaurants

public enum HomeStartSource {
    case appStart
    case deepLink(URL)
}

struct HomeState: Equatable {
    var restaurants: [Restaurant] = []
    var route: Route?
    
    enum Route: Equatable, Hashable {
        func hash(into hasher: inout Hasher) {
            hasher.combine(self)
        }
        
        case restaurant(RestaurantDetailsRoute)
    }
}

struct HomeEnvironment {
    let deliveryClient: DeliveryClientProtocol
}

final class HomeViewModel: ObservableObject {
    @Published var state: HomeState
    private(set) var environment: HomeEnvironment
    
    init(
        initialState: HomeState,
        environment: HomeEnvironment
    ) {
        self.state = initialState
        self.environment = environment
    }
    
    func loadRestaurants() {
        environment.deliveryClient.fetchRestaurant { [weak self] restaurants in
            self?.state.restaurants = restaurants
        }
    }
    
    func selectRestaurant(_ restaurant: Restaurant) {
        let detailsRoute = RestaurantDetailsRoute(
            restaurant: restaurant,
            deliveryClient: environment.deliveryClient
        )
        state.route = .restaurant(detailsRoute)
    }
    
    func someAction() {
        print("Some Action")
    }
}

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
                    case let .restaurant(route):
                        ViewFromRoute(route: route, bindings: RestaurantDetailsBindings(
                            deliveryClient: viewModel.environment.deliveryClient,
                            delegate: nil,
                            onTapSomething: {
                                viewModel.someAction()
                            }
                        ))
                    }
                })
        }
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

struct NavigationStackModifier<Item, Destination: View>: ViewModifier {
    let item: Binding<Item?>
    let destination: (Item) -> Destination
    
    func body(content: Content) -> some View {
        content.background(NavigationLink(isActive: item.mappedToBool()) {
            if let item = item.wrappedValue {
                destination(item)
            } else {
                EmptyView()
            }
        } label: {
            EmptyView()
        })
    }
}

public extension View {
    func navigationDestination<Item, Destination: View>(
        for binding: Binding<Item?>,
        @ViewBuilder destination: @escaping (Item) -> Destination
    ) -> some View {
        self.modifier(NavigationStackModifier(item: binding, destination: destination))
    }
}

public extension Binding where Value == Bool {
    init<Wrapped>(bindingOptional: Binding<Wrapped?>) {
        self.init(
            get: {
                bindingOptional.wrappedValue != nil
            },
            set: { newValue in
                guard newValue == false else { return }
                bindingOptional.wrappedValue = nil
            }
        )
    }
}

extension Binding {
    public func mappedToBool<Wrapped>() -> Binding<Bool> where Value == Wrapped? {
        return Binding<Bool>(bindingOptional: self)
    }
}
