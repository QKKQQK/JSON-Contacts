//
//  DetailViewController.swift
//  Local_JSON
//
//  Created by Qiankang Zhou on 8/17/17.
//  Copyright © 2017 Qiankang Zhou. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var contact: Contact?
    var toolbarButtonText = ""
    var viewingInfo: Bool = true
    
    @IBOutlet weak var textField: UITextView!
    
    @IBOutlet weak var toolbarButton: UIBarButtonItem!
    
    @IBAction func toggleJSON(_ sender: UIBarButtonItem) {
        if viewingInfo {
            sender.title = "View Info"
        } else {
            sender.title = "View JSON"
        }
        viewingInfo = !viewingInfo
        setText()
    }
    
    func setText() {
        if viewingInfo {
            textField.text = contact?.detail
        } else {
            textField.text = contact?.formattedJSON
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toolbarButtonText = "View JSON"
        viewingInfo = true
        setText()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
