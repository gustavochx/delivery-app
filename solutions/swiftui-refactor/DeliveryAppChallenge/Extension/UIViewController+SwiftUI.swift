//
//  UIViewController+SwiftUI.swift
//  DeliveryAppChallenge
//
//  Created by Gustavo Soares on 14/06/22.
//

import UIKit
import SwiftUI

extension UIViewController {
    @available(iOS 13.0, *)
    func presentSwiftUIView<Content: View>(_ swiftUIView: Content) {
        let hostingController = UIHostingController(rootView: swiftUIView)
        present(hostingController, animated: true, completion: nil)
    }
}
