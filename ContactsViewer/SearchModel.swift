//
//  ContactsModel.swift
//  ContactsViewer
//
//  Created by RAVI RANDERIA on 9/12/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation
import UIKit


class SearchModel {
    
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
    func generateContactArray() -> [ContactModel]{
        self.contacts = contactsFramework.returnAllContacts()
        return self.contacts
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

    
    
    private func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredContacts = contacts.filter { contact in
            return contact.firstName.contains(searchText)
        }
    }
    
  
}
