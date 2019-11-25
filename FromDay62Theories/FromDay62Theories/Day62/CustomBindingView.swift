//
//  CustomBindingView.swift
//  FromDay62Theories
//
//  Created by EDGARDO AGNO on 25/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct CustomBindingView: View {
    
    @State private var blurAmount: CGFloat = 0
        
    var body: some View {
        let blur = Binding<CGFloat>(
            get: {
                self.blurAmount
            },
            set: {
                self.blurAmount = $0
                print("New value is \(self.blurAmount)")
            }
        )

        return VStack {
            Text("Prints the blur amount in the console. And allows property observers against the state binding.")
                .blur(radius: blurAmount)

            Slider(value: blur, in: 0...20)
        }
    }
}

struct CustomBindingView_Previews: PreviewProvider {
    static var previews: some View {
        CustomBindingView()
    }
}
