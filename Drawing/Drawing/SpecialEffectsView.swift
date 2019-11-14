//
//  SpecialEffectsView.swift
//  Drawing
//
//  Created by EDGARDO AGNO on 14/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct SpecialEffectsView: View {
    
    @State private var amount: CGFloat = 0.1
    
    var body: some View {
        ScrollView {
            VStack {
                
                VStack(spacing: 5) {
                    Text("blendMode")
                    ZStack {
                        Image("cow")
                        Rectangle()
                            .fill(Color.red)
                            .blendMode(.multiply)
                    }
                    .frame(width: 100, height: 100)
                    .clipped()
                }

                VStack(spacing: 5) {
                    Text("colorMultiply")
                    Image("cow")
                        .colorMultiply(.red)
                }
                
                VStack(spacing: 5) {
                    Text("saturation and blur")

                    Image("cow")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .saturation(Double(amount))
                        .blur(radius: (1 - amount) * 20)
                }

                VStack(spacing: 5) {
                    Text("screen blendMode")

                    ZStack {
                        Circle()
                            .fill(Color.red)
                            .frame(width: 200 * amount)
                            .offset(x: -50, y: -80)
                            .blendMode(.screen)

                        Circle()
                            .fill(Color.green)
                            .frame(width: 200 * amount)
                            .offset(x: 50, y: -80)
                            .blendMode(.screen)

                        Circle()
                            .fill(Color.blue)
                            .frame(width: 200 * amount)
                            .blendMode(.screen)
                    }
                    .frame(width: 200, height: 200)

                    Slider(value: $amount)
                        .padding()
                }
            }
        }
    }
}

struct SpecialEffectsView_Previews: PreviewProvider {
    static var previews: some View {
        SpecialEffectsView()
    }
}
