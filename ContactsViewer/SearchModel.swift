//
//  ContactsModel.swift
//  ContactsViewer
//
//  Created by RAVI RANDERIA on 9/12/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation
import UIKit

struct SearchModel : CurrentModelProtocol,Singleton {
    
    private var contacts = [ContactModel]()
    
    static let sharedInstance = SearchModel()
    private init() {}
    
    var numberOfSections: Int {
        return 1
    }
    
    func setupTableViewCell(cell: ContactsTableViewCell, indexPath: IndexPath) -> ContactsTableViewCell {
        
        cell.nameLabel.text = searchResults[indexPath.row].firstName
        cell.numberLabel.text = searchResults[indexPath.row].firstPhoneNumber
        return cell
    }
    
    func titleForHeaders(section: Int) -> String? {
        return nil
    }
    
    func sectionIndexTitles() -> [String] {
        return []
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return searchResults.count
    }
    
    func didSelectRowReturnContact(indexPath : IndexPath) -> ContactModel {
        return searchResults[indexPath.row]
    }
    
    private var contactsFramework = ContactsFetcher()
    private var filteredContacts = [ContactModel]()
    private(set) var searchIsActive = Bool()
 
    //Returns contactList based on search text
    var searchResults : [ContactModel] {
        if searchIsActive {
            return filteredContacts
        }
        return []
    }

    //Returns all contacts from the phonebook
    mutating func generateContactArray() -> [ContactModel]{
        contacts = contactsFramework.returnAllContacts()
        return contacts
    }
    
    //Search Helper Functions
    mutating func updateSearchResults(text : String){
        filteredContacts.removeAll(keepingCapacity: false)
        filterContentForSearchText(searchText: text)
    }
    
    mutating func setSearchActive(){
        searchIsActive = true
    }
    
    mutating func setSearchInactive(){
        searchIsActive = false
    }
    
    
    //Setup TableView Function

    
    
    private mutating func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredContacts = contacts.filter { contact in
            return contact.firstName.lowercased().contains(searchText.lowercased()) || contact.firstPhoneNumber!.contains((searchText))
        }
    }
    
  
}
