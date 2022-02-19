//
//  RestaurantListViewController.swift
//  DeliveryAppChallenge
//
//  Created by Rodrigo Borges on 27/10/21.
//

import UIKit

class RestaurantListViewController: UIViewController {
    
    let service = DeliveryApi()

    init() {
        super.init(nibName: nil, bundle: nil)

        navigationItem.title = "Restaurant List"
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        self.view = RestaurantListView()
    }
    
    override func viewDidLoad() {
        service.fetchRestaurants { restaurants in
            DispatchQueue.main.async {

                
            }
        }
    }
}
