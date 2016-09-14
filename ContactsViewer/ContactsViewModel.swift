//
//  ContactsModel.swift
//  ContactsViewer
//
//  Created by RAVI RANDERIA on 9/12/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation
import Contacts
import UIKit


class ContactsViewModel {
    
    private let store = CNContactStore()
    private var contacts = [Contact]()
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
    func generateContactList(){
        self.contacts = returnAllContacts()
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
    
    private func returnAllContacts() -> [Contact] {
        
        var contacts = [CNContact]()
        let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
                           CNContactImageDataKey,
                           CNContactPhoneNumbersKey] as [Any]
        
        let fetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch as! [CNKeyDescriptor])
        
        do {
            try store.enumerateContacts(with: fetchRequest, usingBlock: { ( contact, stop) -> Void in
                contacts.append(contact)
            })
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        return convertToContactModel(contactListArray: contacts).sorted(by: ({$0.firstName < $1.firstName}))
    }
    
    private func convertToContactModel(contactListArray : [CNContact]) -> [Contact] {
        
        var contactsModel = [Contact]()
        for contact in contactListArray {
            contactsModel.append(Contact(firstName: contact.givenName, firstPhoneNumber: self.returnFirstNumberFrom(contact: contact)))
        }
        
        return contactsModel
        
    }
    
    private func returnFirstNumberFrom(contact : CNContact) -> String? {
        let phoneNumber = contact.phoneNumbers
        return phoneNumber.first?.value.stringValue
        
    }

    private func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredContacts = contacts.filter { contact in
            return contact.firstName.contains(searchText)
        }
    }
    
  
}
