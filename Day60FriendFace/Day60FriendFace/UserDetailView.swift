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
        GeometryReader { geo in
            ScrollView(.vertical) {
                VStack(spacing: 20) {
                    InitialsView(name: self.user.wrappedName)
                        .frame(width: geo.size.width * 0.5, height: geo.size.width * 0.5)
                    VStack {
                        Text("\(self.user.wrappedName)")
                            .font(.largeTitle)
                        Text(" \(self.user.wrappedEmail), \(self.user.wrappedCompany)")
                        Text(self.user.wrappedAddress)
                    }
                    .font(.caption)
                    
                    Text(self.user.wrappedAbout)
                        .layoutPriority(1)
                    
                    TagsView(tags: self.user.tagArray.map { $0.wrappedTitle })

                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(self.user.friendArray.count) friends")
                            
                            ForEach(self.user.friendArray, id: \.self) { item in
                                HStack {
                                    InitialsView(name: item.wrappedName)
                                        .frame(width: 40, height: 40)
                                    Text(item.wrappedName)
                                }
                            }
                        }
                        
                        Spacer()
                    }                    
                }
                .padding()
            }
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
        user.company = "Apple"
        user.email = "johnappleseed@apple.com"
        user.address = "907 Nelson Street, Cotopaxi, South Dakota, 5913"
        user.about = "Occaecat consequat elit aliquip magna laboris dolore laboris sunt officia adipisicing reprehenderit sunt. Do in proident consectetur labore. Laboris pariatur quis incididunt nostrud labore ad cillum veniam ipsum ullamco. Dolore laborum commodo veniam nisi. Eu ullamco cillum ex nostrud fugiat eu consequat enim cupidatat. Non incididunt fugiat cupidatat reprehenderit nostrud eiusmod eu sit minim do amet qui cupidatat. Elit aliquip nisi ea veniam proident dolore exercitation irure est deserunt.\r\n"
        return UserDetailView(user: user)
    }
}
