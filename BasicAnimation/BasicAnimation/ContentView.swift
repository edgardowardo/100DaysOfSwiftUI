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
                NavigationLink("Animation (Stack)", destination: Stack())
                NavigationLink("Card (Gesture 1)", destination: Gesture())
                NavigationLink("Letters (Gesture 2)", destination: Gesture2())
                NavigationLink("Transition (Asymetric)", destination: Transition())
                NavigationLink("Transition (Modifier)", destination: TransitionModifier())

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
