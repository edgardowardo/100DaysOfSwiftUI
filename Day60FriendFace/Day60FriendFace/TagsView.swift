//
//  TagsView.swift
//  Day60FriendFace
//
//  Created by EDGARDO AGNO on 22/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct TagsView: View {

    var tagsPerRow = 3
    let tags: [String]
    
    var body: some View {
        HStack {
            ForEach(tags, id: \.self) {
                Text($0)
                    .padding(5)
                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
            }
        }
    }
}

struct TagsView_Previews: PreviewProvider {
    static var previews: some View {
        TagsView(tags: [
            "cillum",
            "consequat",
            "deserunt",
            "nostrud",
            "eiusmod",
            "minim",
            "tempor"
        ])
    }
}
