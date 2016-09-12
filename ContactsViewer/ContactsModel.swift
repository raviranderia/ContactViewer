//
//  ContactsModel.swift
//  ContactsViewer
//
//  Created by RAVI RANDERIA on 9/12/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation
import Contacts


class ContactsModel {
    
    func convertToThisModel(contactListArray : [CNContact]) -> [Contact] {
        
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
    
}
