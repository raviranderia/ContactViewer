//
//  CurrentModel.swift
//  ContactsViewer
//
//  Created by RAVI RANDERIA on 9/15/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation



protocol Singleton {
    static var sharedInstance: Self { get }
}

protocol CurrentModelProtocol {
    
    var numberOfSections : Int {get}
    func setupTableViewCell(cell : ContactsTableViewCell,indexPath : IndexPath) -> ContactsTableViewCell
    func titleForHeaders(section : Int) -> String?
    func sectionIndexTitles() -> [String]
    func numberOfRowsInSection(section : Int) -> Int
    func didSelectRowReturnContact(indexPath : IndexPath) -> ContactModel
    
}

