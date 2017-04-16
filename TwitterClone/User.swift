//
//  User.swift
//  TwitterClone
//
//  Created by Thai Cao Ngoc on 14/4/17.
//  Copyright © 2017 Thai Cao Ngoc. All rights reserved.
//

import UIKit
import SwiftyJSON

class User {
    let name: String
    let userName: String
    let bioText: String
    let profileImageUrl: String
    
    init(json: JSON) {
        self.name = json["name"].stringValue
        self.userName = json["username"].stringValue
        self.bioText = json["bio"].stringValue
        self.profileImageUrl = json["profileImageUrl"].stringValue
    }
}
