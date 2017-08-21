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
    var viewAll = false
    
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
        if viewAll {
            return 1
        } else {
            return contacts?.sectionedContacts.count ?? 1
        }
        //return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (viewAll) {
            return contacts?.count ?? 0
        }
        return (contacts?.sectionedContacts[(contacts?.sectionKeys[section])!]?.count)!
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if viewAll {
            return 0
        }
        return 30.0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return contacts?.sectionKeys[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath)
        if (viewAll) {
            let contact = contacts?.contact(at: indexPath)
            cell.textLabel?.attributedText = contact?.boldLastName
            return cell
        }
        let key = contacts?.sectionKeys[indexPath.section]
        let currContact = contacts?.sectionedContacts[key!]![indexPath.row]
        cell.textLabel?.attributedText = currContact?.boldLastName
        return cell
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if viewAll {
            return []
        }
        return contacts?.sectionKeys
    }
    
    @IBOutlet weak var toggleViewButton: UIBarButtonItem!
    
    @IBAction func toggleViewTapped(_ sender: Any) {
        viewAll = !viewAll
        if viewAll {
            toggleViewButton.title = "Section"
        } else {
            toggleViewButton.title = "All"
        }
        self.tableView.reloadData()
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
               // controller.contact = contacts?.contact(at: indexPath)
                if (viewAll) {
                    controller.contact = contacts?.contact(at: indexPath)
                } else {
                    let key = contacts?.sectionKeys[indexPath.section]
                    controller.contact = contacts?.sectionedContacts[key!]![indexPath.row]
                }
            }
            
        } else if segue.identifier == "addContact" {
            let controller = segue.destination as! NewContactTableViewController
            controller.contacts = contacts
        }
    }
}
