import Foundation
import Dependencies
import XCTestDynamicOverlay

// sourcery: swiftDepAutoregister
// TODO: Discuss with Bocato how the Failing implementation should work with computed variables
public protocol EnvironmentProtocol {
    func getBaseURL() -> String
}

// MARK: - Dependency Injection 
public enum EnvironmentDependencyKey: TestDependencyKey {
    public static var testValue: EnvironmentProtocol {
        #if DEBUG
        return EnvironmentFailing()
        #else
        fatalError("`testValue` should not be acessed on non DEBUG builds.")
        #endif
    }
}

public extension DependencyValues {
    var environment: EnvironmentProtocol {
        get { self[EnvironmentDependencyKey.self] }
        set { self[EnvironmentDependencyKey.self] = newValue }
    }
}

#if DEBUG
struct EnvironmentFailing: EnvironmentProtocol {
    init() {}
    
    func getBaseURL() -> String {
        XCTFail("\(#function) should not be invoked")
        return ""
    }
}
#endif
