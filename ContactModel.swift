//
//  Contact.swift
//  ContactsViewer
//
//  Created by RAVI RANDERIA on 9/12/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation
import Contacts

struct ContactModel :Equatable {
    var firstName : String
    var firstPhoneNumber : String?
    
    init(firstName : String = "", firstPhoneNumber : String?) {
        self.firstName = firstName
        self.firstPhoneNumber = firstPhoneNumber
    }
    
    static func convertToContactModel(contactArray : [CNContact]) -> [ContactModel] {
        
        var contactsModel = [ContactModel]()
        for contact in contactArray {
            if contact.givenName != "" {
                if let phoneNumber = returnFirstNumberFrom(contact: contact) {
                    contactsModel.append(ContactModel(firstName: contact.givenName, firstPhoneNumber: phoneNumber))
                }
            }
        }
        return contactsModel
    }
    
    static private func returnFirstNumberFrom(contact : CNContact) -> String? {
        let phoneNumber = contact.phoneNumbers
        return phoneNumber.first?.value.stringValue
        
    }
    
    static func == (contact1 : ContactModel,contact2 :ContactModel) -> Bool {
        return contact1.firstName == contact2.firstName && contact1.firstPhoneNumber == contact2.firstPhoneNumber
    }
    
}
