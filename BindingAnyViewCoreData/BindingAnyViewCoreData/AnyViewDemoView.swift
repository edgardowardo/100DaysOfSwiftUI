//
//  AnyViewDemoView.swift
//  BindingAnyViewCoreData
//
//  Created by EDGARDO AGNO on 18/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct AnyViewDemoView: View {
    
    @Environment(\.horizontalSizeClass) var sizeClass
    
    var body: some View {
        if sizeClass == .compact {
            return HStack {
                Text("Active size class:")
                Text("COMPACT")
            }
            .font(.largeTitle)
        } else {
            return HStack {
                Text("Active size class:")
                Text("REGULAR")
            }
            .font(.largeTitle)
        }
    }
}

struct AnyViewDemoView_Previews: PreviewProvider {
    static var previews: some View {
        AnyViewDemoView()
    }
}
