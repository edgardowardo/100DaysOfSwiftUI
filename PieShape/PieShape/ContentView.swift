//
//  ContentView.swift
//  PieShape
//
//  Created by EDGARDO AGNO on 29/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

extension CGRect {
    var radius: CGFloat {
        return min(size.width, size.height) / 2
    }

    var center: CGPoint {
        return .init(x: midX, y: midY)
    }
}

struct PieShape: Shape {

    let degrees: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: rect.center)
        let startAngle = -degrees - 22.5
        path.addRelativeArc(center: rect.center, radius: rect.radius, startAngle: Angle(degrees: startAngle), delta: Angle(degrees: 45))
        path.closeSubpath()
        return path
    }
}

struct ArcShape: Shape {

    let degrees: Double
    var animationProgress: Double
        
    var animatableData: Double {
        get { return animationProgress }
        set { animationProgress = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        let span = 22.5 //45.0
        var path = Path()
        let startAngle = -degrees - span / 2
        let endAngle = -degrees + span / 2
        path.addArc(center: rect.center, radius: rect.radius * 2 * CGFloat(animationProgress), startAngle: Angle(degrees: startAngle), endAngle: Angle(degrees: endAngle), clockwise: false)
        return path
    }
}

struct ContentView: View {
    
    @State var animationProgress = 0.0
    
    var body: some View {
        ZStack {
            ArcShape(degrees: 45, animationProgress: animationProgress)
                .stroke(lineWidth: 1)
                .animation(
                    Animation
                        .easeOut
                        .speed(0.5)
                        .repeatForever(autoreverses: false))
                .onAppear {
                    withAnimation {
                        self.animationProgress = 1.0
                    }
            }
            
            PieShape(degrees: 180)
                .stroke(lineWidth: 1)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
