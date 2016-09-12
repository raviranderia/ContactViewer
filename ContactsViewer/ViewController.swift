//
//  ViewController.swift
//  ContactsViewer
//
//  Created by RAVI RANDERIA on 9/12/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var contactsTableView: UITableView!

    lazy var contactsFinder = ContactsFetcher()
    var contacts = [Contact]()
    var filteredContacts = [Contact]()
    var searchActive : Bool = false


    func presentAlertController(number : String)   {
        let alertController = UIAlertController(title: "Call?", message: "Are you sure you want to place this call?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("cancelled")
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            print("you have pressed OK button");
            self.makeACallTo(number: number)
        }
        alertController.addAction(OKAction)
        
        self.present(alertController, animated: true, completion:nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        DispatchQueue.global().async {
            self.contacts = self.contactsFinder.returnAllContacts()
            DispatchQueue.main.async {
                self.contactsTableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Calling Functionality using NSURL
    func makeACallTo(number:String){
        if let url:NSURL = NSURL(string: "tel://\(number)") {
            UIApplication.shared.openURL(url as URL)
        }
    }
    
    
    
    
    
    //Table View Functions

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ContactsTableViewCell
        
        
        if(searchActive){
            let contact = filteredContacts[indexPath.row]
            cell.nameLabel.text = contact.firstName
            cell.numberLabel.text = contact.firstPhoneNumber
        
        } else {
            let contact = contacts[indexPath.row]
            cell.nameLabel.text = contact.firstName
            cell.numberLabel.text = contact.firstPhoneNumber
        }
        
        
        
        return cell
    }
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(searchActive) {
            return filteredContacts.count
        }
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(searchActive){
            let contact = filteredContacts[indexPath.row]
            if let contactNumber = contact.firstPhoneNumber {
                presentAlertController(number: contactNumber)
            }
        } else {
            let contact = contacts[indexPath.row]
            if let contactNumber = contact.firstPhoneNumber {
                presentAlertController(number: contactNumber)
            }
        }

    }
}

// Handles Search Functionality


extension ViewController :  UISearchBarDelegate, UISearchDisplayDelegate  {
    
    func filterContentForSearchText(searchText: String) {
        
        filteredContacts = contacts.filter({ (contact) -> Bool in
            let tmp: NSString = contact.firstName as NSString
            let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
            return range.location != NSNotFound
        })
    }
 
    
    
}

