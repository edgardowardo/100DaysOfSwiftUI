//
//  ImagePaintView.swift
//  Drawing
//
//  Created by EDGARDO AGNO on 13/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct ImagePaintView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("Hello World")
                    .frame(width: 300, height: 300)
                    .background(Color.red)
                
                Text("Hello World")
                    .frame(width: 300, height: 300)
                    .border(Color.red, width: 30)
                
                Text("Hello World")
                    .frame(width: 300, height: 300)
                    .background(Image("cow"))
                
                Text("Hello World")
                    .frame(width: 300, height: 300)
                    .border(ImagePaint(image: Image("cow"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.1), width: 30)
                Text("Hello World")
                    .frame(width: 300, height: 300)
                    .border(ImagePaint(image: Image("cow"), scale: 0.2), width: 30)
                Capsule()
                    .strokeBorder(ImagePaint(image: Image("cow"), scale: 0.1), lineWidth: 20)
                    .frame(width: 300, height: 200)
            }
        }
    }
}

struct ImagePaintView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePaintView()
    }
}
