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


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchResultsUpdating   {

    @IBOutlet weak var contactsTableView: UITableView!

    lazy var contactsFinder = ContactsFetcher()
    var resultSearchController = UISearchController()
    var contacts = [Contact]()
    var filteredContacts = [Contact]()


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
                self.resultSearchController = ({
                    let controller = UISearchController(searchResultsController: nil)
                    controller.searchResultsUpdater = self
                    controller.dimsBackgroundDuringPresentation = false
                    controller.searchBar.sizeToFit()
                    
                    self.contactsTableView.tableHeaderView = controller.searchBar
                    
                    return controller
                })()
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
        
        
        if (self.resultSearchController.isActive) {
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
        
        if (self.resultSearchController.isActive) {
            return filteredContacts.count
        }
        return contacts.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (self.resultSearchController.isActive) {
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
    
    
    func updateSearchResults(for searchController: UISearchController) {
        
        filteredContacts.removeAll(keepingCapacity: false)
        
        filterContentForSearchText(searchText: searchController.searchBar.text!)
        
        
    }
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredContacts = contacts.filter { contact in
            let firstName : NSString = contact.firstName as NSString
            return firstName.contains(searchText)
        }
        
    }
}

// Handles Search Functionality


    
    


