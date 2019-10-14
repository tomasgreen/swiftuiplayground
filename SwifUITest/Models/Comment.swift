//
//  Comment.swift
//  SwifUITest
//
//  Created by Tomas Green on 2019-10-11.
//  Copyright © 2019 Evry AB. All rights reserved.
//

import Foundation

struct Comment : Codable {
    let id:UUID
    var user:User
    var content:String
}

class CommentViewModel : Identifiable {
    let id = UUID()
    let comment:Comment
    let user:UserViewModel
    init(comment:Comment) {
        self.comment = comment
        user = UserViewModel(user: comment.user)
    }
    var content:String {
        return comment.content
    }
}
