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
                NavigationLink("Scale & Blur (Implicit)", destination: Implicit())
                NavigationLink("Pulsar (Customised)", destination: CustomisingAnimation())
                NavigationLink("Custom (Bindings)", destination: AnimatingBindings())
                NavigationLink("3D Effect (Explicit)", destination: Explicit())
                NavigationLink("Animation stack", destination: Stack())
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
