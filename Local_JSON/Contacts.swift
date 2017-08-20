//
//  Contacts.swift
//  Local_JSON
//
//  Created by Qiankang Zhou on 8/15/17.
//  Copyright © 2017 Qiankang Zhou. All rights reserved.
//
import Foundation
import UIKit

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
    
    var boldLastName: NSAttributedString {
        let attributedFullName = NSMutableAttributedString(string: self.fullName)
        attributedFullName.addAttributes([NSAttributedStringKey.font : UIFont.boldSystemFont(ofSize: 18)], range: NSMakeRange(firstName.count + 1, lastName.count))
        return attributedFullName
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

class Contacts {
    var contacts: [Contact]
    var sectionedContacts: Dictionary<String, Array<Contact>> = [:]
    
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
            print("Loading bundled JSON.")
            contacts = loadBundledJSON()
            createContactsPlistFile()
        } else {
            print("Loading contacts from app directory.")
            contacts = loadSavedContacts()
        }
        self.sort()
        self.loadSortedContacts()
    }
    
    func sort() {
        contacts.sort{
            if ($0.lastName != $1.lastName) {
                return $0.lastName < $1.lastName
                
            } else {
                return $0.firstName < $1.firstName
                
            }
        }
    }
    
    func loadSortedContacts() {
        for contact in contacts {
            let key = getKey(contact)
            if var contactSection = sectionedContacts[key] {
                contactSection.append(contact)
//                contactSection.sort( by: {
//                    if ($0.lastName != $1.lastName) {
//                        return $0.lastName < $1.lastName
//                    } else {
//                        return $0.firstName < $1.firstName
//                    }
//                })
                sectionedContacts.updateValue(contactSection, forKey: key)
            } else {
                sectionedContacts.updateValue([contact], forKey: key)
            }
        }
    }
    
    func getKey(_ newContact: Contact) -> String {
        var key = newContact.lastName.capitalized.prefix(1).description
        do {
            let regex = try NSRegularExpression(pattern: "[a-zA-Z]")
            let result = regex.matches(in: key, range: NSMakeRange(0, 1))
            if result.count == 0 {
                key = "#"
            }
        } catch {
            print("Regex error")
        }
        return key
    }
    
    func addToContacts(_ newContact: Contact) {
        contacts.append(newContact)
        self.sort()
    }
    
    func addToSectionedContacts(_ newContact: Contact) {
        let key = getKey(newContact)
        if var contactSection = sectionedContacts[key] {
            contactSection.append(newContact)
            contactSection.sort( by: {
                if ($0.lastName != $1.lastName) {
                    return $0.lastName < $1.lastName
                } else {
                    return $0.firstName < $1.firstName
                }
            })
            sectionedContacts.updateValue(contactSection, forKey: key)
        } else {
            sectionedContacts.updateValue([newContact], forKey: key)
        }
    }
    
    func loadBundledJSON() -> [Contact] {
        let url = Bundle.main.url(forResource: "small-contacts", withExtension: "json")
        
        guard let jsonData = try? Data(contentsOf: url!) else {
            return []
        }
        
        let jsonDecoder = JSONDecoder()
        
        let contactsArray = try? jsonDecoder.decode([Contact].self, from: jsonData)
        
        return contactsArray ?? []
    }
    
    func loadSavedContacts() -> [Contact] {
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
