import Foundation
import UIKit

public typealias RouterIdentifier = String

public protocol Route: Identifiable {
    static var identifier: RouterIdentifier { get }
}

public extension Route {
    var id: String {
        Self.identifier
    }
}
