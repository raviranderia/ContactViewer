//
//  ContactsFetcherFramework.swift
//  ContactsViewer
//
//  Created by RAVI RANDERIA on 9/14/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import Foundation
import Contacts


struct ContactsFetcher {
    
    private let store: CNContactStore
    
    init(contactStore: CNContactStore = CNContactStore()) {
        store = contactStore
    }
    
    //TODO: Pass Error if error while loading contacts
    
    func returnAllContacts() -> [ContactModel] {
        
        var contacts = [CNContact]()
        let keysToFetch : [CNKeyDescriptor] = [CNContactGivenNameKey,
                           CNContactImageDataKey,
                           CNContactPhoneNumbersKey].map { (key) -> CNKeyDescriptor in
                            return key as CNKeyDescriptor
                            }
        
        
        let fetchRequest = CNContactFetchRequest(keysToFetch: keysToFetch)
        
        do {
            
            try store.enumerateContacts(with: fetchRequest, usingBlock: { ( contact, stop) -> Void in
                contacts.append(contact)
            })
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        return ContactModel.convertToContactModel(contactArray: contacts).sorted(by: ({$0.firstName < $1.firstName}))
    }
}
