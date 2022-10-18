import UIKit
import Navigation
import RestaurantsInterface
import ServicesInterface

//final class HomeFactory {
//
//    struct Dependencies {}
//
//    static func make(with dependecies: Dependencies) -> UIViewController {
//        let customView = HomeView()
//        let deliveryApi = DeliveryApi()
//        let viewController = HomeViewController(customView: customView, deliveryApi: deliveryApi)
//        customView.delegate = viewController
//        return viewController
//    }
//}

final class HomeViewController: UIViewController {
    
    private let deliveryApi: DeliveryApiProtocol
    private let customView: HomeViewProtocol
    private let navigator: NavigatorProtocol
    
    init(customView: HomeViewProtocol, deliveryApi: DeliveryApiProtocol, navigator: NavigatorProtocol) {
        self.customView = customView
        self.deliveryApi = deliveryApi
        self.navigator = navigator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Delivery App"
        customView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchRestaurants()
    }
    
    func fetchRestaurants() {
        deliveryApi.fetchRestaurants { [weak self] restaurants in
            DispatchQueue.main.async {
                guard let self = self else {return}
                self.customView.displayRestaurants(.init(restaurants: restaurants))
            }
        }
    }
}

extension HomeViewController: HomeViewDelegate {
    func didTapOnRestaurantCell() {
        let restaurantDetailsRoute = RestaurantDetailsRoute(presentationStyle: PushPresentationStyle())
        try? navigator.navigate(to: restaurantDetailsRoute, from: self)
    }
}
