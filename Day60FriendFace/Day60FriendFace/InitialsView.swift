//
//  InitialsView.swift
//  Day60FriendFace
//
//  Created by EDGARDO AGNO on 22/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct InitialsView: View {
    
    let name: String
    
    var initials: String {
        let names = name.components(separatedBy: " ")
        return "\(names.first!.prefix(1))\(names.last!.prefix(1))"
    }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Circle()
                    .shadow(radius: 10)
                    .foregroundColor(.gray)
                Text(self.initials)
                    .font(.system(size: geo.size.height * 0.5))
                    .foregroundColor(.white)
            }
        }
    }
}
struct InitialsView_Previews: PreviewProvider {
    static var previews: some View {
        InitialsView(name: "John Appleseed")
            .frame(width: 300, height: 300)
    }
}
