//
//  User.swift
//  SwifUITest
//
//  Created by Tomas Green on 2019-10-11.
//  Copyright © 2019 Evry AB. All rights reserved.
//

import Foundation

struct User : Codable {
    let id:UUID
    let name:String
    let image:URL
}

class UserViewModel : Identifiable {
    let id = UUID()
    let user:User
    init(user:User) {
        self.user = user
    }
    var name:String {
        return user.name
    }
    var image:URL {
        return user.image
    }
}
