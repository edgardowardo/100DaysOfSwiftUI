//
//  User.swift
//  Day60FriendFace
//
//  Created by EDGARDO AGNO on 22/11/2019.
//  Copyright © 2019 EDGARDO AGNO. All rights reserved.
//

import Foundation
import CoreData

struct UserJSON: Codable, Identifiable {
    let id: String
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String
    let tags: [String]
    let friends: [FriendJSON]
}

extension UserJSON {
    struct FriendJSON: Codable {
        let id: String
        let name: String
    }
}

private extension String {
    func tag(for context: NSManagedObjectContext, in id: String) -> Tag {
        let tag = Tag(context: context)
        tag.title = self
        tag.userId = id
        return tag
    }
}

extension UserJSON.FriendJSON {
    func friend(for context: NSManagedObjectContext, in relatedUserId: String) -> Friend {
        let friend = Friend(context: context)
        friend.id = id
        friend.name = name
        friend.relatedUserId = relatedUserId
        return friend
    }
}

extension UserJSON {
    func user(for context: NSManagedObjectContext) -> User {
        let user = User(context: context)
        user.id = id
        user.isActive = isActive
        user.name = name
        user.age = Int16(age)
        user.company = company
        user.email = email
        user.address = address
        user.about = about

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        user.registered = dateFormatter.date(from: registered)
        
        user.tag = NSSet(array: tags.map { $0.tag(for: context, in: id) })
        user.friend = NSSet(array: friends.map { $0.friend(for: context, in: id) })
        return user
    }
}

extension User{
    public var wrappedId: String { id ?? "Unknown ID" }
    public var wrappedName: String { name ?? "Unknown name" }
    public var wrappedCompany: String { company ?? "Unknown company" }
    public var wrappedEmail: String { email ?? "Unknown email" }
    public var wrappedAddress: String { address ?? "Unknown address" }
    public var wrappedAbout: String { about ?? "Unknown about" }

}

extension Tag {
    public var wrappedTitle: String { title ?? "Unknown title" }
}

extension Friend {
    public var wrappedId: String { id ?? "Unknown ID" }
    public var wrappedName: String { name ?? "Unknown name" }
}

extension User {

    public var tagArray: [Tag] {
        let set = tag as? Set<Tag> ?? []
        return set.sorted {
            $0.wrappedTitle < $1.wrappedTitle
        }
    }

    public var friendArray: [Friend] {
        let set = friend as? Set<Friend> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}
