//
//  UINavigationController+SwiftUI.swift
//  DeliveryAppChallenge
//
//  Created by Gustavo Soares on 14/06/22.
//

import UIKit
import SwiftUI

extension UINavigationController {
    func pushSwiftUIView<Content: View>(_ swiftUIView: Content) {
        let hostingController = UIHostingController(rootView: swiftUIView)
        pushViewController(hostingController, animated: true)
    }
}
