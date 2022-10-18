import Foundation
import UIKit

public typealias SceneFactory = (_ route: Route) -> UIViewController

public enum NavigatorFailure: Error {
    case invalidPresentationStyle
    case withoutNavigationController
    case invalidRoute
}

public enum SceneRegistrationFailure: Error {
    case alreadyExist
}

// TODO: Testing the whole navigation and thinking about communicate between scenes
public protocol NavigatorProtocol {
    func navigate(to route: Route, from: UIViewController) throws
}

public protocol SceneRegisteringProtocol {
    func registerFactory(factory: @escaping SceneFactory, for route: Route.Type) throws
}

public final class RouterService: NavigatorProtocol, SceneRegisteringProtocol {
    public static let shared = RouterService()
    
    private(set) var factories: [RouterIdentifier : SceneFactory] = [:]
    
    public init() {}

    public func navigate(to route: Route, from: UIViewController) throws {
        let destinationController = try mapRouteToController(route)
        switch route.presentationStyle {
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
                animated: presentationStyle.animated,
                completion: presentationStyle.completion
            )
        default:
            throw NavigatorFailure.invalidPresentationStyle
        }
    }

    private func mapRouteToController(_ route: Route) throws -> UIViewController {
        let identifier = type(of: route).identifier
        guard let makeControllerForRoute = factories[identifier] else {
            throw NavigatorFailure.invalidRoute
        }
        return makeControllerForRoute(route)
    }

    public func registerFactory(factory: @escaping SceneFactory, for route: Route.Type) throws {

        guard factories[route.identifier] == nil else {
            throw SceneRegistrationFailure.alreadyExist
        }

        factories[route.identifier] = factory
    }
}
