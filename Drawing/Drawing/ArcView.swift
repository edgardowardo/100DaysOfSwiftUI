//
//  ArcView.swift
//  Drawing
//
//  Created by EDGARDO AGNO on 13/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct Arc: InsettableShape {
    let adjusted: Bool
    var insetAmount: CGFloat = 0
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool

    func path(in rect: CGRect) -> Path {
        if adjusted {
//            let rotationAdjustment = Angle.degrees(90)
            let modifiedStart = startAngle //- rotationAdjustment
            let modifiedEnd = -endAngle // - rotationAdjustment

            var path = Path()
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2 - insetAmount, startAngle: modifiedStart, endAngle: modifiedEnd, clockwise: clockwise)

            return path
        } else {
            var path = Path()
            path.addArc(center: CGPoint(x: rect.midX, y: rect.midY), radius: rect.width / 2, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
            
            return path
        }
    }
    
    func inset(by amount: CGFloat) -> some InsettableShape {
        var arc = self
        arc.insetAmount += amount
        return arc
    }
}

struct ArcView: View {
    let adjusted: Bool
    let insettable: Bool
    
    var body: some View {
        VStack {
            if insettable {
                Arc(adjusted: adjusted, startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
                    .strokeBorder(Color.blue, lineWidth: 40)
                    .frame(width: 300, height: 300)
            }
            if !insettable {
                Arc(adjusted: adjusted, startAngle: .degrees(0), endAngle: .degrees(110), clockwise: true)
                    .stroke(Color.blue, lineWidth: 10)
                    .frame(width: 300, height: 300)
            }
        }
    }
}

struct ArcView_Previews: PreviewProvider {
    static var previews: some View {
        ArcView(adjusted: true, insettable: false)
    }
}
