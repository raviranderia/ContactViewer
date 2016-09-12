//
//  ContactsFetcher.swift
//  ContactsViewer
//
//  Created by RAVI RANDERIA on 9/12/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation
import Contacts

class ContactsFetcher {
    
    private let store = CNContactStore()
    private let contactsModelHelper = ContactsModel()
    
    func returnAllContacts() -> [Contact] {
        
        var contacts = [CNContact]()
        let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
                           CNContactImageDataKey,
                           CNContactPhoneNumbersKey] as [Any]
        
        let fetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch as! [CNKeyDescriptor])
        
        do {
            try store.enumerateContacts(with: fetchRequest, usingBlock: { ( contact, stop) -> Void in
                contacts.append(contact)
            })
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        
        return contactsModelHelper.convertToThisModel(contactListArray: contacts)
    }
    
}
