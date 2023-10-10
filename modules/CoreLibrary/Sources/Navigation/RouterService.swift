import Foundation
import UIKit
import SwiftUI

public typealias SceneFactory = (_ route: any Route, _ bindings: Any?) -> UIViewController

public enum NavigatorFailure: Error {
    case invalidPresentationStyle
    case withoutNavigationController
    case invalidRoute
}

public enum SceneRegistrationFailure: Error {
    case alreadyExist
}

public protocol NavigatorProtocol {
    func navigate<Bindings>(
        to route: any Route,
        from: UIViewController,
        presentationStyle: PresentationStyle,
        bindings: Bindings?
    ) throws
    
    func controller(for route: any Route) throws -> UIViewController
}
public extension NavigatorProtocol {
    func navigate(
        to route: any Route,
        from controller: UIViewController,
        presentationStyle: PresentationStyle
    ) {
        try? self.navigate(to: route, from: controller, presentationStyle: presentationStyle, bindings: ())
    }
}

public protocol SceneRegisteringProtocol {
    func registerFactory(factory: @escaping SceneFactory, for route: any Route.Type) throws
}

public final class RouterService: NavigatorProtocol, SceneRegisteringProtocol {
    public static let shared = RouterService()
    
    private(set) var factories: [RouterIdentifier : SceneFactory] = [:]
    
    public init() {}

    public func navigate<Bindings>(
        to route: any Route,
        from: UIViewController,
        presentationStyle: PresentationStyle,
        bindings: Bindings?
    ) throws {
        let destinationController = try mapRouteToController(route, bindings: bindings)
        switch presentationStyle {
        case let presentationStyle as PushPresentationStyle:
            guard let navigationController = from.navigationController else {
                throw NavigatorFailure.withoutNavigationController
            }

            navigationController.pushViewController(
                destinationController,
                animated: presentationStyle.animated
            )

        case let presentationStyle as PresentPresentationStyle:
            from.present(
                destinationController,
                animated: presentationStyle.animated
            )
        default:
            throw NavigatorFailure.invalidPresentationStyle
        }
    }
    
    public func controller(for route: any Route) throws -> UIViewController {
        try mapRouteToController(route, bindings: nil)
    }

    public func registerFactory(factory: @escaping SceneFactory, for route: any Route.Type) throws {

        guard factories[route.identifier] == nil else {
            throw SceneRegistrationFailure.alreadyExist
        }

        factories[route.identifier] = factory
    }
}

private extension RouterService {
    func mapRouteToController(_ route: any Route, bindings: Any?) throws -> UIViewController {
        let identifier = type(of: route).identifier
        guard let makeControllerForRoute = factories[identifier] else {
            throw NavigatorFailure.invalidRoute
        }
        return makeControllerForRoute(route, bindings)
    }
}

// MARK: Wrapping ViewController into a SwiftUI
public struct ViewFromRoute: View {
    let route: any Route
    let bindings: Any?
    
    public init(route: any Route, bindings: Any? = nil) {
        self.route = route
        self.bindings = bindings
    }
    
    public var body: some View {
        ToSwiftUI {
            try! RouterService.shared.mapRouteToController(route, bindings: bindings)
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
