import Foundation
import Dependencies

// sourcery: swiftDepAutoregister
public struct StageEnvironment: EnvironmentProtocol {
    public func getBaseURL() -> String {
        "https://raw.githubusercontent.com/devpass-tech/challenge-delivery-app/main/api/"
    }
}

extension EnvironmentDependencyKey: DependencyKey {
    public static var liveValue: EnvironmentProtocol {
        StageEnvironment()
    }
}

