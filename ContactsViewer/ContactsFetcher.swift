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
    
    func returnAllContacts() -> [ContactModel] {
        
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
        return ContactModel.convertToContactModel(contactArray: contacts).sorted(by: ({$0.firstName < $1.firstName}))
    }
}
