//
//  AnimatableDataView.swift
//  Drawing
//
//  Created by EDGARDO AGNO on 14/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct Trapezoid: Shape {
    var insetAmount: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: 0, y: rect.maxY))
        path.addLine(to: CGPoint(x: insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - insetAmount, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: 0, y: rect.maxY))

        return path
    }
    
    var animatableData: CGFloat {
        get { insetAmount }
        set { self.insetAmount = newValue }
    }
}

struct AnimatableDataView: View {
    
    @State private var insetAmount: CGFloat = 50
    
    var body: some View {
        Trapezoid(insetAmount: insetAmount)
            .frame(width: 200, height: 100)
            .onTapGesture {
                withAnimation {
                    self.insetAmount = CGFloat.random(in: 10...90)
                }
            }
    }
}

struct AnimatableDataView_Previews: PreviewProvider {
    static var previews: some View {
        AnimatableDataView()
    }
}
