//
//  ContactsModel.swift
//  ContactsViewer
//
//  Created by RAVI RANDERIA on 9/12/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation
import UIKit

protocol SearchModelProtocol {
    var searchResults : [ContactModel] {get}
    mutating func generateContactArray() -> [ContactModel]
    mutating func updateSearchResults(text : String)
    mutating func setSearchActive()
    mutating func setSearchInactive()
}

struct SearchModel : SearchModelProtocol {
    
    private var contacts = [ContactModel]()
    
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
