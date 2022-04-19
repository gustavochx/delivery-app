//
//  MenuItemViewController.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 31/10/21.
//

import UIKit

class MenuItemViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)

        navigationItem.title = "Menu Item"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = MenuItemView()
    }
}
