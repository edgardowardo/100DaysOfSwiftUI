//
//  UserDetailView.swift
//  Day60FriendFace
//
//  Created by EDGARDO AGNO on 22/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import SwiftUI
import CoreData

struct UserDetailView: View {
    
    let user: User
    
    var body: some View {
        NavigationView {
            Text("\(user.wrappedName)")
                .font(.largeTitle)
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)

    static var previews: some View {
        let user = User(context: moc)
        user.id = "1"
        user.name = "John Appleseed"
        user.age = 21
        return UserDetailView(user: user)
    }
}
