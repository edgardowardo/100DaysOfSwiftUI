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
                NavigationLink("Arc", destination: ArcView(adjusted: false, insettable: false))
                NavigationLink("Arc adjusted", destination: ArcView(adjusted: true, insettable: false))
                NavigationLink("Arc insettable", destination: ArcView(adjusted: true, insettable: true))
                NavigationLink("Circle not inset", destination: InsettableView(insettable: false))
                NavigationLink("Circle insettable", destination: InsettableView(insettable: true))
                NavigationLink("Flower", destination: FlowerView())
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
