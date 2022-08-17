//
//  RestaurantDetailsRoute.swift
//  DeliveryAppChallenge
//
//  Created by Gustavo Soares on 17/08/22.
//

import Foundation

struct RestaurantDetailsRoute: Route {
    static var identifier: RouterIdentifier {
        "RestaurantDetails"
    }

    var presentationStyle: PresentationStyle

    init(presentationStyle: PresentationStyle) {
        self.presentationStyle = presentationStyle
    }
}
