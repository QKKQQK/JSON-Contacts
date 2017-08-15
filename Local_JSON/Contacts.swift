//
//  Contacts.swift
//  Local_JSON
//
//  Created by Qiankang Zhou on 8/15/17.
//  Copyright © 2017 Qiankang Zhou. All rights reserved.
//

import Foundation

struct Contact: Codable, CustomStringConvertible {
    var firstName: String
    var lastName: String
    var email: String
    var cell: String
    
    var fullName:String {
        return "\(firstName) \(lastName)"
    }
    
    var detail:String {
        return "\(firstName) \(lastName)\nEmail: \(email)\nCell#: \(cell)\n"
    }
    
    var description: String {
        return "\(firstName) \(lastName)"
    }
}

class Contacts {
    
}
