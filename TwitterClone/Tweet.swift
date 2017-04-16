//
//  Tweet.swift
//  TwitterClone
//
//  Created by Thai Cao Ngoc on 15/4/17.
//  Copyright © 2017 Thai Cao Ngoc. All rights reserved.
//

import Foundation
import SwiftyJSON

class Tweet {
    let user: User
    let message: String
    
    init(json: JSON) {
        let userDictionay = json["user"]
        self.user = User(json: userDictionay)
        self.message = json["message"].stringValue
    }
}
