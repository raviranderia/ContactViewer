//
//  ContactViewModel.swift
//  ContactsViewer
//
//  Created by RAVI RANDERIA on 9/15/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation

class ContactViewModel {
    
    var searchModel = SearchModel()
    var sectionModel = SectionModel()

    var searchIsActive : Bool {
        return searchModel.searchIsActive
    }
    
    func setSearchActive(){
        self.searchModel.setSearchActive()
    }
    
    func setSearchInactive(){
        self.searchModel.setSearchInactive()
    }
    
    func generateContactArrayAndSectionDictionary() {
        
        self.sectionModel.generateSectionsForModel(contacts: self.searchModel.generateContactArray())
    }
    
    func setupTableViewCell(cell : ContactsTableViewCell,indexPath : IndexPath) -> ContactsTableViewCell {
        
        if searchIsActive {
            cell.nameLabel.text = searchModel.searchResults[indexPath.row].firstName
            cell.numberLabel.text = searchModel.searchResults[indexPath.row].firstPhoneNumber
        }
        else {
            let sectionContact = sectionModel.rowsForSection(indexPath: indexPath)
            cell.nameLabel.text = sectionContact.firstName
            cell.numberLabel.text = sectionContact.firstPhoneNumber
        }
        return cell
        
    }
    
    var numberOfSections : Int {
        
        if searchIsActive {
            return 1
        }
        return sectionModel.letters.count
    }
    
    func titleForHeaders(section : Int) -> String? {
        if searchIsActive {
            return nil
        }
        return String(sectionModel.letters.sorted()[section])
    }
    
    
    func numberOfRowsInSection(section : Int) -> Int {
        if searchIsActive {
            return self.searchModel.searchResults.count
        }
        let alphabet = sectionModel.letters.sorted()[section]
        return sectionModel.contactsDictionary[alphabet]!.count
    }
    
    func didSelectRowReturnContact(indexPath : IndexPath) -> ContactModel {
        if searchIsActive {
            return self.searchModel.searchResults[indexPath.row]
        }
        else{
            return self.sectionModel.findContactForIndexPath(indexPath: indexPath)
        }
    }
    
    func updateSearchResults(text : String) {
        searchModel.updateSearchResults(text: text)
    }
    
    
    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("1234567890+".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }
    
    
    
}
