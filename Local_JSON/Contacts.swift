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
    
    init(data: [String]) {
        self.firstName = data[0]
        self.lastName = data[1]
        self.email = data[2]
        self.cell = data[3]
    }
    
    var fullName:String {
        return "\(firstName) \(lastName)"
    }
    
    var detail:String {
        return "\(firstName) \(lastName)\nEmail: \(email)\nCell#: \(cell)\n"
    }
    
    var formattedJSON: String {
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        
        guard let json = try? encoder.encode(self) else {
            print("Can't create JSON for contact")
            return ""
        }
        
        return String(data: json, encoding: .utf8) ?? ""
    }
    
    var description: String {
        return "\(firstName) \(lastName)"
    }
}

class ContactSection {
    var section: [Contact]
    
    init() {
        section = []
    }
    
    var count: Int {
        return section.count
    }
    
    func getContactWithinSection(indexPath: IndexPath) -> Contact {
        if indexPath.row >= section.count {
            return section[0]
        }
        return section[indexPath.row]
    }
}
