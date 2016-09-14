//
//  ContactsModel.swift
//  ContactsViewer
//
//  Created by RAVI RANDERIA on 9/12/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation
import UIKit


class ContactsViewModel {
    
    private var contacts = [Contact]()
    private var contactsFramework = ContactsFetcherFramework()
    private var filteredContacts = [Contact]()
    private var searchIsActive = Bool()
    
    //Returns contactList based on search text
    var searchResults : [Contact] {
        if searchIsActive {
            return filteredContacts
        }
        return contacts
    }

    //Returns all contacts from the phonebook
    func generateContactArray(){
        self.contacts = contactsFramework.returnAllContacts()
    }
    
    //Search Helper Functions
    func updateSearchResults(text : String){
        filteredContacts.removeAll(keepingCapacity: false)
        filterContentForSearchText(searchText: text)
    }
 
    func setSearchActive(){
        self.searchIsActive = true
    }
    
    func setSearchInactive(){
        self.searchIsActive = false
    }
    
  
    
    //Setup TableView Function
    func setupTableViewCell(cell : ContactsTableViewCell,indexPath : IndexPath) -> ContactsTableViewCell {
        cell.nameLabel.text = searchResults[indexPath.row].firstName
        cell.numberLabel.text = searchResults[indexPath.row].firstPhoneNumber
        return cell
    }
    
    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("1234567890+".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }
    
    
    private func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredContacts = contacts.filter { contact in
            return contact.firstName.contains(searchText)
        }
    }
    
  
}
