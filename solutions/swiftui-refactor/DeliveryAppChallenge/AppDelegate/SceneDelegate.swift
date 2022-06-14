//
//  SceneDelegate.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 25/10/21.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)

        // TODO: using swiftUI setUp just
        if #available(iOS 13.0, *) {
            setUpSwiftUIInterop()
        } else {
            setUpUIKitInterop()
        }

        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
    }

    private func setUpSwiftUIInterop() {
        let mainView = MainView()
        let mainViewHostingController = UIHostingController(rootView: mainView)
        window?.rootViewController = mainViewHostingController
    }

    private func setUpUIKitInterop() {
        let viewController = HomeFactory.make(with: .init())
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        window?.rootViewController = navigationController
    }
}

