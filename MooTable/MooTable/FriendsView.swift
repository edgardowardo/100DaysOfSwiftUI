//
//  FriendsView.swift
//  MooTable
//
//  Created by EDGARDO AGNO on 29/10/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI

struct FriendsView: View {
    let friendsCount: Int
    let friends: [Int]
    
    var body: some View {
        HStack(spacing: 20) {
            Text("\(friendsCount)")
                .animation(nil)
            VStack {
                HStack {
                    ForEach(friends.prefix(6), id: \.self) { _ in
                        Image("cow")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
                HStack {
                    if friends.count >= 6 {
                        ForEach(friends[6...], id: \.self) { _ in
                            Image("cow")
                                .resizable()
                                .frame(width: 30, height: 30)
                        }
                    }
                }

            }
        }
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView(friendsCount: 12, friends: [Int](repeatElement(0, count: 12)))
    }
}
