import Foundation
import UIKit

public enum AppNavigationFailure: Error {
    case invalidPresentationStyle
    case withoutNavigationController
    case invalidRoute
}

public protocol AppNavigator {
    func navigate<Bindings>(
        to route: any Route,
        from: UIViewController,
        presentationStyle: PresentationStyle,
        bindings: Bindings?
    ) throws

    func controller(for route: any Route, bindings: Any?) throws -> UIViewController
}

public extension AppNavigator {
    func navigate(
        to route: any Route,
        from controller: UIViewController,
        presentationStyle: PresentationStyle
    ) {
        try? navigate(to: route, from: controller, presentationStyle: presentationStyle, bindings: ())
    }
}

// MARK: - Dependency Injection

import Dependencies
import XCTestDynamicOverlay

internal enum AppNavigatorDependencyKey: DependencyKey {
    static var liveValue: AppNavigator {
        @Dependency(\.navigationService) var navigationService
        return navigationService
    }
    
    static var testValue: AppNavigator {
        #if DEBUG
        return NavigationServiceFailing()
        #else
        fatalError("`testValue` should not be acessed on non DEBUG builds.")
        #endif
    }
}

public extension DependencyValues {
    var appNavigator: AppNavigator {
        get { self[AppNavigatorDependencyKey.self] }
        set { self[AppNavigatorDependencyKey.self] = newValue }
    }
}
