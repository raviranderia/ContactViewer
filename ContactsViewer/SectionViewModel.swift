//
//  SectionViewModel.swift
//  ContactsViewer
//
//  Created by RAVI RANDERIA on 9/14/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation


class SectionViewModel {
    
    func convertContactsToADictionaryModelForSections(contactsArray : [Contact]) ->  [Character: [Contact]] {
        
        var letters: [Character]
        
        letters = self.makeLetterArray(contactsArray: contactsArray)
        
        letters = letters.reduce([], { (list, name) -> [Character] in
            if !list.contains(name) {
                return list + [name]
            }
            return list
        })
        
        var contactsDictionary = [Character: [Contact]]()
        
        for contact in contactsArray {
            
            if contactsDictionary[contact.firstName[contact.firstName.startIndex]] == nil {
                contactsDictionary[contact.firstName[contact.firstName.startIndex]] = [Contact]()
            }
            contactsDictionary[contact.firstName[contact.firstName.startIndex]]!.append(contact)
        }
        
        return contactsDictionary
    }
    

    private func makeLetterArray(contactsArray : [Contact]) -> [Character] {
        
        let contactsWithNames = contactsArray.filter { (contact) -> Bool in
            return contact.firstName != ""
        }
        
        return contactsWithNames.map { (contact) -> Character in
            return contact.firstName[contact.firstName.startIndex]
        }.sorted()

    }
}
