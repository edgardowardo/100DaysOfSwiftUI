//
//  Transition.swift
//  BasicAnimation
//
//  Created by EDGARDO AGNO on 26/10/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct Transition: View {
    
    @State private var isShowingRed = false

    var body: some View {
          VStack {
              Button("Tap Me") {
                  withAnimation {
                      self.isShowingRed.toggle()                  
                }
            }

              if isShowingRed {
                  Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
//                    .transition(.scale)
                    .transition(.asymmetric(insertion: .scale, removal: .opacity))
              }
          }
          .navigationBarTitle("Transition")
      }
}

struct Transition_Previews: PreviewProvider {
    static var previews: some View {
        Transition()
    }
}
