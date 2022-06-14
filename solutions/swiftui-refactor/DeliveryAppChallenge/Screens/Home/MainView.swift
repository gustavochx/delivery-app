//
//  MainView.swift
//  DeliveryAppChallenge
//
//  Created by Gustavo Soares on 14/06/22.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Main")
            }
            .navigationTitle("Delivery App")
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
