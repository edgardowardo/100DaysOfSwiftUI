//
//  CustomisingAnimation.swift
//  BasicAnimation
//
//  Created by EDGARDO AGNO on 26/10/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct CustomisingAnimation: View {

    private let animationEnd = CGFloat(2.5)
    @State private var animationAmount: CGFloat = 1

    var body: some View {
        Text("5")
            .font(.largeTitle)
        .padding(40)
        .background(Color.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        .overlay(
            Circle()
                .stroke(lineWidth: animationEnd - animationAmount )
                .foregroundColor(.red)
                .scaleEffect(animationAmount)
                .opacity(Double(animationEnd - animationAmount))
                .animation(
                    Animation.easeOut(duration: 1)
                        .repeatForever(autoreverses: false)
                )
        )
        .onAppear {
            self.animationAmount = self.animationEnd
        }
    .navigationBarTitle("Pulsar")
    }
}


struct CustomisingAnimation_Previews: PreviewProvider {
    static var previews: some View {
        CustomisingAnimation()
    }
}
