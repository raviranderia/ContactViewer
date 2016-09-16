//
//  ContactsViewerTests.swift
//  ContactsViewerTests
//
//  Created by RAVI RANDERIA on 9/14/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import XCTest
import Contacts

@testable import ContactsViewer

class ContactsViewerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testRemoveSpecialCharactersFromNumber(){
        let dummyNumber = "+1(929)-253-2101"
        let answer = "+19292532101"
        let viewModel = ContactViewModel()
        XCTAssertEqual(viewModel.removeSpecialCharsFromString(text: dummyNumber), answer)
        
    }
        
 
    func testIfCNContactGetsConvertedToContactModel() {
        //Create Contact Model Object
        let contact1 = ContactModel()
        contact1.firstName = "Bob"
        contact1.firstPhoneNumber = "9292532101"
        
        //Create CNContact Object
        let newContact = CNMutableContact()
        newContact.givenName = "Bob"
        let phoneNumber = CNLabeledValue(label: CNLabelPhoneNumberMain, value: CNPhoneNumber(stringValue: "9292532101"))
        newContact.phoneNumbers = [phoneNumber]
        
        let convertedContact = ContactModel.convertToContactModel(contactArray: [newContact]).first!
        
        XCTAssertEqual(contact1, convertedContact)
      
        
    }
    
    func testContactWithoutFirstNameOrFirstPhoneNumberShouldNotBeAdded(){
 
        let contactWithoutName = CNMutableContact()
        let phoneNumber = CNLabeledValue(label: CNLabelPhoneNumberMain, value: CNPhoneNumber(stringValue: "9292532101"))
        contactWithoutName.phoneNumbers = [phoneNumber]
        
        XCTAssertEqual(ContactModel.convertToContactModel(contactArray: [contactWithoutName]).count, 0)
        
        
        
        let contactwithoutNumber = CNMutableContact()
        contactWithoutName.givenName = "Bob"
        
        XCTAssertEqual(ContactModel.convertToContactModel(contactArray: [contactwithoutNumber]).count, 0)
    }
    
    
    func testCheckDictionaryConversionOfContactArray() {
        
        let contact1 = ContactModel(firstName: "Tom", firstPhoneNumber: "1111111111")
        let contact5 = ContactModel(firstName: "Terry", firstPhoneNumber: "1111111111")
        let contact2 = ContactModel(firstName: "Bob", firstPhoneNumber: "2222222222")
        let contact3 = ContactModel(firstName: "Peter", firstPhoneNumber: "2222222222")
        let contact4 = ContactModel(firstName: "Megan", firstPhoneNumber: "2222222222")
        
        let contactArray = [contact1,contact2,contact3,contact4,contact5]
        
        let expectedAnswer : [Character : [ContactModel]] = ["B" : [contact2],
                              "T" : [contact1,contact5],
                              "P" : [contact3],
                              "M" : [contact4]]
        
        var sectionModelObject = SectionModel()
        sectionModelObject.convertContactsToADictionaryModelForSections(contactsArray: contactArray)
        
        
        XCTAssertTrue(NSDictionary(dictionary: sectionModelObject.contactsDictionary) == NSDictionary(dictionary: expectedAnswer))
        

    }
    
    
}
