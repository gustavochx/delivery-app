import Foundation
import UIKit

public typealias SceneFactory = (_ route: Route, _ bindings: Any?) -> UIViewController

public enum SceneRegistrationFailure: Error {
    case alreadyExist
}

public protocol SceneRegistration {
    func registerFactory(factory: @escaping SceneFactory, for route: Route.Type) throws
}

// MARK: - Dependency Injection

import Dependencies
import XCTestDynamicOverlay

internal enum SceneRegistrationDependencyKey: DependencyKey {
    static var liveValue: SceneRegistration {
        @Dependency(\.navigationService) var navigationService
        return navigationService
    }
    
    static var testValue: SceneRegistration {
        #if DEBUG
        return NavigationServiceFailing()
        #else
        fatalError("`testValue` should not be acessed on non DEBUG builds.")
        #endif
    }
}

public extension DependencyValues {
    var sceneRegistration: SceneRegistration {
        get { self[SceneRegistrationDependencyKey.self] }
        set { self[SceneRegistrationDependencyKey.self] = newValue }
    }
}
