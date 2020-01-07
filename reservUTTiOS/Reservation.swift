//
//  Reservation.swift
//  reservUTTiOS
//
//  Created by edifixio on 20/12/2019.
//  Copyright © 2019 edifixio. All rights reserved.
//

import Foundation
import FirebaseFirestore

protocol ReservationSerializable {
    init?(dictionary:[String:Any])
}

struct Reservation {
    var done: Bool
    var salleId: String
    var salleName:String
    var slot: Int
    var time:String
    var timestamp: Timestamp
    var user:String
    var userId: String

    var dictionary:[String:Any]{
        return [
            "done":done,
            "salleId":salleId,
            "salleName": salleName,
            "slot": slot,
            "time":time,
            "timestamp": timestamp,
            "user":user,
            "userId": userId
        ]
    }
}

extension Reservation : ReservationSerializable {
    init?(dictionary:[String:Any]){
        guard   let done = dictionary["done"] as? Bool,
            let salleId = dictionary["salleId"] as? String,
            let salleName = dictionary["salleName"] as? String,
            let slot = dictionary["slot"] as? Int,
            let time = dictionary["time"] as? String,
            let timestamp = dictionary["timestamp"] as? Timestamp,
            let user = dictionary["user"] as? String,
            let userId = dictionary["userId"] as? String else {return nil}
        self.init(done: done, salleId : salleId, salleName: salleName, slot:slot, time: time, timestamp: timestamp, user: user, userId: userId)
    }
    
}
