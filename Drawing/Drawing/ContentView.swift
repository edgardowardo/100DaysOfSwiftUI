//
//  ContentView.swift
//  Drawing
//
//  Created by EDGARDO AGNO on 13/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink("Triangle fill", destination: TriangleView(isFill: true))
                NavigationLink("Triangle border", destination: TriangleView(isFill: false))
            }
            .navigationBarTitle("Drawings")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
