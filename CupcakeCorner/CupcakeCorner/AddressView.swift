//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by EDGARDO AGNO on 16/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct AddressView: View {

    @ObservedObject var container: OrderContainer
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $container.order.name)
                TextField("Street Address", text: $container.order.streetAddress)
                TextField("City", text: $container.order.city)
                TextField("Zip", text: $container.order.zip)
            }

            Section {
                NavigationLink(destination: CheckoutView(order: container)) {
                    Text("Check out")
                }
            }
            .disabled(container.order.hasValidAddress == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(container: OrderContainer())
    }
}
