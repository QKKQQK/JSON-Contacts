//
//  TableViewController.swift
//  Local_JSON
//
//  Created by Qiankang Zhou on 8/15/17.
//  Copyright © 2017 Qiankang Zhou. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var contacts : Contacts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return contacts?.sectionedContacts.count ?? 1
        //return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let keyList = contacts?.sectionedContacts.keys.sorted()
        let count = contacts?.sectionedContacts[keyList![section]]?.count
        return count ?? 0
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return contacts?.sectionedContacts.keys.sorted()[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)

        let key = contacts?.sectionedContacts.keys.sorted()[indexPath.section]
        let currContact = contacts?.sectionedContacts[key!]![indexPath.row]
        //cell.textLabel?.text = currContact?.fullName
        cell.textLabel?.attributedText = currContact?.boldLastName
        //contact?.fullName
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "showDetail" {
            let controller = segue.destination as! DetailViewController
            
            if let indexPath = tableView.indexPathForSelectedRow {
                controller.contact = contacts?.contact(at: indexPath)
            }
            
        } else if segue.identifier == "addContact" {
            let controller = segue.destination as! NewContactTableViewController
            controller.contacts = contacts
        }
    }
}
