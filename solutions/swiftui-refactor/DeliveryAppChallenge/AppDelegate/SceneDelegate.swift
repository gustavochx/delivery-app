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
        let mainView = MainView()
        let mainViewHostingController = UIHostingController(rootView: mainView)

        window?.rootViewController = mainViewHostingController
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
    }

    // MARK: In case that we want to go back to the UIKit
    private func setUpUIKitInterop() {
        let viewController = HomeFactory.make(with: .init())
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        window?.rootViewController = navigationController
    }
}
