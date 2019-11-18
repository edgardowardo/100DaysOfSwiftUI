//
//  ContentView.swift
//  DrawingChallenge
//
//  Created by EDGARDO AGNO on 16/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct Arrow: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let stemWidth = rect.midX / 2
        let leftStem = (rect.maxX - stemWidth) / 2
        path.move(to: .init(x: rect.midX, y: 0))
        path.addLine(to: .init(x: 0, y: rect.midY / 2))
        path.addLine(to: .init(x: leftStem, y: rect.midY / 2))
        path.addLine(to: .init(x: leftStem, y: rect.maxY))
        path.addLine(to: .init(x: leftStem + stemWidth, y: rect.maxY))
        path.addLine(to: .init(x: leftStem + stemWidth, y: rect.midY / 2))
        path.addLine(to: .init(x: rect.maxX, y: rect.midY / 2))
        path.closeSubpath()
        
        return path
    }
}

struct ContentView: View {
    
    @State var lineWidth: CGFloat = 5
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("ColorCyclingRetcangleView", destination: ColorCyclingRecangleView())
                Arrow()
                    .stroke(lineWidth: lineWidth)
                    .onTapGesture {
                        withAnimation {
                            self.lineWidth *= 1.5
                        }
                }

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
