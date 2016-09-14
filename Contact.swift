//
//  Contact.swift
//  ContactsViewer
//
//  Created by RAVI RANDERIA on 9/12/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation
import Contacts

class Contact {
    var firstName : String
    var firstPhoneNumber : String?
    
    init(firstName : String, firstPhoneNumber : String?) {
        self.firstName = firstName
        self.firstPhoneNumber = firstPhoneNumber
    }
    
    init(){
        self.firstName = ""
    }
    
    func convertToContactModel(contactArray : [CNContact]) -> [Contact] {
        
        var contactsModel = [Contact]()
        for contact in contactArray {
            if contact.givenName != "" {
                if let phoneNumber = returnFirstNumberFrom(contact: contact) {
                    contactsModel.append(Contact(firstName: contact.givenName, firstPhoneNumber: phoneNumber))
                }
            }
        }
        return contactsModel
    }
    
    private func returnFirstNumberFrom(contact : CNContact) -> String? {
        let phoneNumber = contact.phoneNumbers
        return phoneNumber.first?.value.stringValue
        
    }
}
