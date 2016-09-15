//
//  SectionViewModel.swift
//  ContactsViewer
//
//  Created by RAVI RANDERIA on 9/14/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation

struct SectionModel : CurrentModelProtocol,Singleton {
    
    private(set) var letters = [Character]()
    private(set) var contactsDictionary = [ Character : [ContactModel] ]()
    
    static let sharedInstance = SectionModel()
    private init() {}
    
    var numberOfSections: Int {
        return letters.count
    }
    
    func rowsForSection(indexPath : IndexPath) -> ContactModel {
        
        let contactArrayForCharacter = contactsDictionary[letters.sorted()[indexPath.section]]
        return contactArrayForCharacter![indexPath.row]
        
    }
    
    func setupTableViewCell(cell: ContactsTableViewCell, indexPath: IndexPath) -> ContactsTableViewCell {
        
        let sectionContact = rowsForSection(indexPath: indexPath)
        cell.nameLabel.text = sectionContact.firstName
        cell.numberLabel.text = sectionContact.firstPhoneNumber

        return cell
    }
    
    func titleForHeaders(section: Int) -> String? {
        return String(letters.sorted()[section])
    }
    
    func sectionIndexTitles() -> [String] {
        return letters.sorted().map()  { (char) -> String in
            return String(char)
        }
    }
    
    func numberOfRowsInSection(section : Int) -> Int {
        let alphabet = letters.sorted()[section]
        return contactsDictionary[alphabet]!.count
    }
    
    mutating func generateSectionsForModel( contacts : [ContactModel] ) {
        convertContactsToADictionaryModelForSections(contactsArray: contacts)
    }
    
    func didSelectRowReturnContact(indexPath : IndexPath) -> ContactModel {
        return findContactForIndexPath(indexPath: indexPath)
    }
    
    func findContactForIndexPath(indexPath : IndexPath) -> ContactModel {
        let sectionContact = rowsForSection(indexPath: indexPath)
        return sectionContact
    }
    
    mutating func convertContactsToADictionaryModelForSections(contactsArray : [ContactModel]) {
        
        letters = makeLetterArray(contactsArray: contactsArray)
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
    
    func makeLetterArray(contactsArray : [ContactModel]) -> [Character] {
        
        let contactsWithNames = contactsArray.filter { (contact) -> Bool in
            return contact.firstName != ""
        }
        
        return contactsWithNames.map { (contact) -> Character in
            return contact.firstName[contact.firstName.startIndex]
            }.sorted()
        
    }
}
