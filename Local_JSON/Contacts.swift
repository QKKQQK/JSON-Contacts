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
    var contacts: [Contact]
    
    init() {
        contacts = []
        loadContacts()
    }
    
    var count: Int {
        return contacts.count
    }
    
    func contact(at indexPath: IndexPath) -> Contact {
        if indexPath.row >= contacts.count {
            return contacts[0]
        }
        
        return contacts[indexPath.row]
    }
    
    func loadContacts() {
        if isFirstLaunch() {
            print("First launch, loading bundled JSON.")
            contacts = loadBundledJSON()
            createContactsPlistFile()
        } else {
            print("Loading contacts from app directory.")
            contacts = loadSavedContacts()
        }
    }
    
    func loadBundledJSON() -> [Contact] {
        let url = Bundle.main.url(forResource: "small-contacts", withExtension: "json")
        
        guard let jsonData = try? Data(contentsOf: url!) else {
            return []
        }
        
        let jsonDecoder = JSONDecoder()
        // [Contact].self return the type
        let contactsArray = try? jsonDecoder.decode([Contact].self, from: jsonData)
        
        return contactsArray ?? []
    }
    
    func loadSavedContacts() -> [Contact] {
        print("In loadSavedContacts")
        
        guard let contactsURL = applicationDirectory().appendingPathComponent("contacts.plist") else {
            print("Can't create URl to app dir.")
            return []
        }
        
        guard let contactsData = try? Data.init(contentsOf: contactsURL) else {
            print("Couldn't load data from app dir.")
            return []
        }
        
        let contactsDecoder = PropertyListDecoder()
        let contactsArray = try? contactsDecoder.decode([Contact].self, from: contactsData)
        
        return contactsArray ?? []
    }
    
    func createContactsPlistFile() {
        guard let contactsPlistFileURL = applicationDirectory().appendingPathComponent("contacts.plist") else {
            print("Could not get the URL for the data save.")
            return
        }
        
        let plistEncoder = PropertyListEncoder()
        
        // nil if fail, contacts.self stands for type
        let contactsData = try? plistEncoder.encode(contacts.self)
        
        do {
            try contactsData?.write(to: contactsPlistFileURL)
        } catch {
            print(error)
        }
    }
}
