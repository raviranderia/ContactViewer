//
//  ContactViewModel.swift
//  ContactsViewer
//
//  Created by RAVI RANDERIA on 9/15/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation
import UIKit

protocol ContactViewModelProtocol {
   
    //tableView Helper methods
    var numberOfSections : Int {get}
    func setupTableViewCell(cell : ContactsTableViewCell,indexPath : IndexPath) -> ContactsTableViewCell
    func titleForHeaders(section : Int) -> String?
    func sectionIndexTitles() -> [String]
    func numberOfRowsInSection(section : Int) -> Int
    func didSelectRowReturnContact(indexPath : IndexPath) -> ContactModel

    //UISearchController helper methods
    mutating func updateSearchResults(text : String)
    mutating func setSearchActive()
    mutating func setSearchInactive()
    
    //loading contacts initially
    mutating func generateContactArrayAndSectionDictionary()
    
    //general helper function
    func removeSpecialCharsFromString(text: String) -> String
}

struct ContactViewModel : ContactViewModelProtocol {
    
    private var searchModel = SearchModel()
    private var sectionModel = SectionModel()

    private var searchIsActive : Bool {
        return searchModel.searchIsActive
    }
    
    mutating func setSearchActive(){
        searchModel.setSearchActive()
    }
    
    mutating func setSearchInactive(){
        searchModel.setSearchInactive()
    }
    
    mutating func updateSearchResults(text : String) {
        searchModel.updateSearchResults(text: text)
    }
    
    mutating func generateContactArrayAndSectionDictionary() {
        
        sectionModel.generateSectionsForModel(contacts: searchModel.generateContactArray())
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
    
    func sectionIndexTitles() -> [String] {
        if searchIsActive {
            return []
        }
        return sectionModel.letters.sorted().map()  { (char) -> String in
            return String(char)
        }
    }
    
    
    func numberOfRowsInSection(section : Int) -> Int {
        if searchIsActive {
            return searchModel.searchResults.count
        }
        let alphabet = sectionModel.letters.sorted()[section]
        return sectionModel.contactsDictionary[alphabet]!.count
    }
    
    func didSelectRowReturnContact(indexPath : IndexPath) -> ContactModel {
        if searchIsActive {
            return searchModel.searchResults[indexPath.row]
        }
        else{
            return sectionModel.findContactForIndexPath(indexPath: indexPath)
        }
    }

    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("1234567890+".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }
    
    
    
}
