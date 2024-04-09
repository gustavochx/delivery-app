import SwiftUI
import UIKit

public struct ViewFromRoute: View {
    let route: any Route
    let bindings: Any?
    let navigationService: any AppNavigator
    
    public init(
        route: any Route,
        navigationService: AppNavigator,
        bindings: Any? = nil
    ) {
        self.route = route
        self.navigationService = navigationService
        self.bindings = bindings
    }
    
    public var body: some View {
        ToSwiftUI {
            try! navigationService.controller(for: route, bindings: bindings)
        }
    }
}

struct ToSwiftUI: UIViewControllerRepresentable {
    let controller: () -> UIViewController
    
    func makeUIViewController(context: Context) -> some UIViewController {
        controller()
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}
