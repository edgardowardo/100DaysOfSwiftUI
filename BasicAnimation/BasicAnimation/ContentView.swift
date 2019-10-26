//
//  ContentView.swift
//  BasicAnimation
//
//  Created by EDGARDO AGNO on 26/10/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Scale (Implicit)", destination: ImplicitAnimation())
                NavigationLink("Pulsar (Customised)", destination: CustomisingAnimation())
            }
        .navigationBarTitle("Animation 101")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
