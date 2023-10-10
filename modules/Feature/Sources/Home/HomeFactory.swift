import Foundation
import Services
//import UIKit
import SwiftUI
import ServicesInterface

public final class HomeFactory {
    public static func make(
        source: HomeStartSource
    ) -> UIViewController {
        let homeViewModel = HomeViewModel(
            initialState: .init(),
            environment: .init(deliveryClient: DeliveryClient())
        )
        return UIHostingController(rootView: HomeView(viewModel: homeViewModel))
    }
}
