//
//  ContactAll.swift
//  Local_JSON
//
//  Created by Qiankang Zhou on 8/20/17.
//  Copyright © 2017 Qiankang Zhou. All rights reserved.
//

import Foundation

class ContactAll {
    func loadContacts() {
        if isFirstLaunch() {
            print("Loading bundled JSON.")
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
