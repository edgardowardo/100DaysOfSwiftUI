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
    var rowCount: Int { tags.count / tagsPerRow }
    var remainder: Int { tags.count % tagsPerRow }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ForEach(0..<rowCount) { indexRow in
                HStack {
                    ForEach(0..<self.tagsPerRow) { indexCol in
                        Text(self.tags[(indexRow * self.tagsPerRow) + indexCol])
                            .padding(5)
                            .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                    }
                }
            }
            if remainder > 0 {
                HStack {
                    ForEach(0..<remainder) { indexCol in
                        Text(self.tags[(self.rowCount * self.tagsPerRow) + indexCol])
                            .padding(5)
                            .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                    }
                }
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
