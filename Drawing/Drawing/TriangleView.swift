//
//  TriangleView.swift
//  Drawing
//
//  Created by EDGARDO AGNO on 13/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))

        return path
    }
}

struct TriangleView: View {
    let isFill: Bool
    
    var body: some View {
        VStack {
            if isFill {
                Triangle()
                    .fill(Color.red)
                    .frame(width: 300, height: 300)
            }
            if !isFill {
                Triangle()
                    .stroke(Color.red, style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                    .frame(width: 300, height: 300)
            }
        }
    }
}

struct TriangleView_Previews: PreviewProvider {
    static var previews: some View {
        TriangleView(isFill: true)
    }
}
