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

class ContactViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchResultsUpdating,UISearchControllerDelegate  {

    @IBOutlet weak var contactsTableView: UITableView!
    
    var contactViewModel = ContactViewModel()
    var resultSearchController : UISearchController!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupSearchController()
        DispatchQueue.global().async {
            self.contactViewModel.generateContactArrayAndSectionDictionary()
            DispatchQueue.main.async {
                self.contactsTableView.reloadData()
            }
        }
    }
    
    func setupSearchController() {
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            contactsTableView.tableHeaderView = controller.searchBar
            return controller
        })()
        resultSearchController.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Table View Functions

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! ContactsTableViewCell
        return contactViewModel.setupTableViewCell(cell: cell, indexPath: indexPath)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return contactViewModel.numberOfSections
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return contactViewModel.titleForHeaders(section: section)
    }
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return contactViewModel.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let contact = contactViewModel.didSelectRowReturnContact(indexPath: indexPath)
        presentCallAlertController(name: contact.firstName,number: contact.firstPhoneNumber!)
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return contactViewModel.sectionIndexTitles()
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        print("setActive")
        contactViewModel.setSearchActive()
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        print("dismissed")
        contactViewModel.setSearchInactive()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print("updated")
        print(resultSearchController.searchBar.text)
        contactViewModel.updateSearchResults(text: resultSearchController.searchBar.text!)
        contactsTableView.reloadData()
    }
    
    //Call Function
    func makeACallTo(number:String){
        if number != "" {
            DispatchQueue.main.async {
                if let url:URL = URL(string: "tel://\(self.contactViewModel.removeSpecialCharsFromString(text: number))") {
                    UIApplication.shared.openURL(url)
                }
            }
        }
        else{
            presentErrorAlertController()
        }
    }
    
    
    func presentCallAlertController(name : String,number : String)   {
        let alertController = UIAlertController(title: "Call?", message: "Would you like to call \(name) at number: \(number)?", preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            print("cancelled")
        }
        alertController.addAction(cancelAction)
        
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
            print("you have pressed OK button");
            self.makeACallTo(number: number)
        }
        alertController.addAction(OKAction)
        
        if resultSearchController.isActive {
            resultSearchController.present(alertController, animated: true, completion: nil)
        }
        else{
            present(alertController, animated: true, completion:nil)
        }
    }
    
    func presentErrorAlertController(){
        let alertController = UIAlertController(title: "Error", message: "Cannot call since no number is associated with this contact" , preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        
        if resultSearchController.isActive {
            resultSearchController.present(alertController, animated: true, completion: nil)
        }
        else{
            present(alertController, animated: true, completion:nil)
        }
        
    }
    
    
}
