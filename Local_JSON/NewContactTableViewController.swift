//
//  NewContactTableViewController.swift
//  Local_JSON
//
//  Created by Qiankang Zhou on 8/17/17.
//  Copyright © 2017 Qiankang Zhou. All rights reserved.
//

import UIKit

class NewContactTableViewController: UITableViewController {

    var contacts: Contacts?
    var data: [String] = []
    
    @IBAction func saveContact(_ sender: Any) {
        // if all 4 text field check passed
        if checkAllFieldFilled() {
            contacts?.addToContacts(Contact(data: data))
            contacts?.addToSectionedContacts(Contact(data: data))
            contacts?.createContactsPlistFile()
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func checkAllFieldFilled() -> Bool {
        var allFilled = true
        data = []
        for case let cell as UITableViewCell in self.view.subviews{
            for case let textField as UITextField in cell.contentView.subviews {
                if textField.text == "" {
                    allFilled = false
                    textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.5)])
                }
                data.insert(textField.text ?? "N/A", at: 0)
            }
        }
        return allFilled
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
