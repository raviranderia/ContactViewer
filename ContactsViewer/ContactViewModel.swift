//
//  ContactViewModel.swift
//  ContactsViewer
//
//  Created by RAVI RANDERIA on 9/15/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation
import UIKit

struct ContactViewModel {
    
    var currentSubModel : CurrentSubModelProtocol {
        if searchIsActive {
            return searchModel
        }
        return sectionModel
    }
    
    private var searchModel = SearchModelView()
    private var sectionModel = SectionModelView()

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
        return currentSubModel.setupTableViewCell(cell: cell, indexPath: indexPath)
    }
    
    var numberOfSections : Int {
        return currentSubModel.numberOfSections
    }
    
    func titleForHeaders(section : Int) -> String? {
        return currentSubModel.titleForHeaders(section: section)
    }
    
    mutating func sectionIndexTitles() -> [String] {
        return currentSubModel.sectionIndexTitles()
    }
    
    
    func numberOfRowsInSection(section : Int) -> Int {
        return currentSubModel.numberOfRowsInSection(section: section)
    }
    
    func didSelectRowReturnContact(indexPath : IndexPath) -> ContactModel {
        return currentSubModel.didSelectRowReturnContact(indexPath: indexPath)
    }

    func removeSpecialCharsFromString(text: String) -> String {
        let okayChars : Set<Character> =
            Set("1234567890+".characters)
        return String(text.characters.filter {okayChars.contains($0) })
    }
    
    
    
}
