//
//  Gesture2.swift
//  BasicAnimation
//
//  Created by EDGARDO AGNO on 26/10/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct Gesture2: View {
      let letters = Array("Hello SwiftUI")
      @State private var enabled = false
      @State private var dragAmount = CGSize.zero

      var body: some View {
          HStack(spacing: 0) {
              ForEach(0..<letters.count) { num in
                  Text(String(self.letters[num]))
                      .padding(5)
                      .font(.title)
                      .background(self.enabled ? Color.blue : Color.red)
                      .offset(self.dragAmount)
                      .animation(Animation.default.delay(Double(num) / 20))
              }
          }
          .gesture(
              DragGesture()
                  .onChanged { self.dragAmount = $0.translation }
                  .onEnded { _ in
                      self.dragAmount = .zero
                      self.enabled.toggle()
                  }
          )
        .navigationBarTitle("Drag Letters")
      }
}
