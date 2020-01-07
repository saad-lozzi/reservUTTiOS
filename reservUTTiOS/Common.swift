//
//  Common.swift
//  reservUTTiOS
//
//  Created by edifixio on 13/12/2019.
//  Copyright © 2019 edifixio. All rights reserved.
//

import Foundation


class Common {
    static var USERNAME = "USERNAME"
    static var PROFESSION = "PREFESSION"
    static var BATIMENT = "A"
    static var SALLE = "A101"
    static var SALLEID = "ID"
    static var SLOT = -1
    static var TIME = "TIME"
    static var DATE = "DATE"
    static var DATETIME = "DATETIME"
    
    
    public static func convertTimeSlotToString(slot: Int) -> String
    {
        switch slot {
        case 0:
            return "8:00 - 9:00"
        case 1:
            return "9:00 - 10:00"
        case 2:
            return "10:00 - 11:00"
        case 3:
            return "11:00 - 12:00"
        case 4:
            return "14:00 - 15:00"
        case 5:
            return "15:00 - 16:00"
        case 6:
            return "16:00 - 17:00"
        case 7:
            return "17:00 - 18:00"
        default:
            return "Fermé"
        }
    }
    
    
}
