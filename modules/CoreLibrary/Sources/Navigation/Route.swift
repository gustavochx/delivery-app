import Foundation
import UIKit

public typealias RouterIdentifier = String

public protocol PresentationStyle {}

public protocol Route: Identifiable {
    static var identifier: RouterIdentifier { get }
}

public extension Route {
    var id: String {
        Self.identifier
    }
}

public struct PushPresentationStyle: PresentationStyle {
    let animated: Bool

    public init(animated: Bool = true) {
        self.animated = animated
    }
}

public struct PresentPresentationStyle: PresentationStyle {
    let animated: Bool

    public init(animated: Bool = true) {
        self.animated = animated
    }
}
