//
//  ContactsViewerTests.swift
//  ContactsViewerTests
//
//  Created by RAVI RANDERIA on 9/14/16.
//  Copyright © 2016 RAVI RANDERIA. All rights reserved.
//

import XCTest

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
        
 
}
