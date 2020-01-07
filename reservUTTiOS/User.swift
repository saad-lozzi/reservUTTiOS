//
//  User.swift
//  reservUTTiOS
//
//  Created by edifixio on 14/12/2019.
//  Copyright © 2019 edifixio. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol DocumentSerializable {
    init?(dictionary:[String:Any])
}

struct User {
    var email:String
    var username:String
    var id:String
    var profession:String

    var dictionary:[String:Any]{
        return [
            "email": email,
            "username":username,
            "id":id,
            "profession":profession
        ]
    }
}

extension User : DocumentSerializable {
    init?(dictionary:[String:Any]){
        guard let email = dictionary["email"] as? String,
            let username = dictionary["username"] as? String,
            let id = dictionary["id"] as? String,
            let profession = dictionary["profession"] as? String else {return nil}
        self.init(email: email, username: username, id:id, profession: profession)
    }
    
}



/*class User
{
    var email:String = "email"
    var id:String = "id"
    var profession:String = "profession"
    var username:String = "username"

    init(email: String, id: String, profession: String, username: String) {
        self.email = email
        self.profession = profession
        self.username = username
        self.id = id
    }

}
*/
