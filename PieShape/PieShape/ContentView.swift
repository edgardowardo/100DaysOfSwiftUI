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

struct ContentView: View {
    var body: some View {
        PieShape(degrees: 360)
            .stroke(lineWidth: 1)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
