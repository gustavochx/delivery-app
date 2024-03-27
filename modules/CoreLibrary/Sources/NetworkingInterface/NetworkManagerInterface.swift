import Foundation
import Dependencies
import XCTestDynamicOverlay

public typealias NetworkResult<T: Decodable> = (Result<T, Error>) -> Void

public protocol NetworkManagerProtocol {
    func request<T: Decodable>(_ request: NetworkRequest, completion: @escaping NetworkResult<T>)
}

public enum NetworkManagerDependencyKey: TestDependencyKey {
    public static var testValue: NetworkManagerProtocol {
        #if DEBUG
        return NetworkManagerFailing()
        #else
        fatalError("`testValue` should not be acessed on non DEBUG builds.")
        #endif
    }
}

public extension DependencyValues {
    var networkManager: NetworkManagerProtocol {
        get { self[NetworkManagerDependencyKey.self] }
        set { self[NetworkManagerDependencyKey.self] = newValue }
    }
}

#if DEBUG
public struct NetworkManagerFailing: NetworkManagerProtocol {
    init() {}
    
    public func request<T>(_ request: NetworkRequest, completion: @escaping NetworkResult<T>) where T : Decodable {
        XCTFail("\(#function) should not be called")
    }
}
#endif
