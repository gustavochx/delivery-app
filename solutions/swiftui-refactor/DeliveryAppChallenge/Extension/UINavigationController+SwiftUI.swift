//
//  UINavigationController+SwiftUI.swift
//  DeliveryAppChallenge
//
//  Created by Gustavo Soares on 14/06/22.
//

import UIKit
import SwiftUI

extension UINavigationController {
    @available(iOS 13.0, *)
    func pushSwiftUIView<Content: View>(_ swiftUIView: Content) {
        let hostingController = UIHostingController(rootView: swiftUIView)
        pushViewController(swiftUIView, animated: true)
    }
}
