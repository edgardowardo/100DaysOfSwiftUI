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
                Section {
                    NavigationLink("Triangle fill", destination: TriangleView(isFill: true))
                    NavigationLink("Triangle border", destination: TriangleView(isFill: false))
                    NavigationLink("Arc", destination: ArcView(adjusted: false, insettable: false))
                    NavigationLink("Arc adjusted", destination: ArcView(adjusted: true, insettable: false))
                    NavigationLink("Arc insettable", destination: ArcView(adjusted: true, insettable: true))
                    NavigationLink("Circle not inset", destination: InsettableView(insettable: false))
                    NavigationLink("Circle insettable", destination: InsettableView(insettable: true))
                    NavigationLink("Flower", destination: FlowerView(isFilled: false))
                    NavigationLink("Flower filled eof (even odd)", destination: FlowerView(isFilled: true))
                    NavigationLink("Image paint", destination: ImagePaintView())
                }
                Section {
                    NavigationLink("Color Cycling Circlen on Metal", destination: ColorCyclingCircleView())
                    NavigationLink("Special effects", destination: SpecialEffectsView())
                    NavigationLink("Animatable data Trapezoid", destination: AnimatableDataView())
                    NavigationLink("Animatable pair checkerboard", destination: AnimatablePairView())
                }
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
