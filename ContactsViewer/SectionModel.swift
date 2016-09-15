//
//  SectionViewModel.swift
//  ContactsViewer
//
//  Created by RAVI RANDERIA on 9/14/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation


class SectionModel {
    
    var letters = [Character]()
    var contactsDictionary = [Character: [ContactModel]]()
    
    func generateSectionsForModel(contacts : [ContactModel]) {
        self.convertContactsToADictionaryModelForSections(contactsArray: contacts)
    }
    
    func convertContactsToADictionaryModelForSections(contactsArray : [ContactModel]) {
        
        letters = self.makeLetterArray(contactsArray: contactsArray)
        letters = letters.reduce([], { (list, name) -> [Character] in
            if !list.contains(name) {
                return list + [name]
            }
            return list
        })
        
        for contact in contactsArray {
            
            if contactsDictionary[contact.firstName[contact.firstName.startIndex]] == nil {
                contactsDictionary[contact.firstName[contact.firstName.startIndex]] = [ContactModel]()
            }
            contactsDictionary[contact.firstName[contact.firstName.startIndex]]!.append(contact)
        }
    }
    

    private func makeLetterArray(contactsArray : [ContactModel]) -> [Character] {
        
        let contactsWithNames = contactsArray.filter { (contact) -> Bool in
            return contact.firstName != ""
        }
        
        return contactsWithNames.map { (contact) -> Character in
            return contact.firstName[contact.firstName.startIndex]
        }.sorted()

    }
    
    func rowsForSection(indexPath : IndexPath) -> ContactModel {
        
        let contactArrayForCharacter = contactsDictionary[letters.sorted()[indexPath.section]]
        return contactArrayForCharacter![indexPath.row]
        
    }
    
    func findContactForIndexPath(indexPath : IndexPath) -> ContactModel {
        let sectionContact = rowsForSection(indexPath: indexPath)
        return sectionContact
    }
    
    
    
}
