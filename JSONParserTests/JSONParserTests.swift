//
//  JSONParserTests.swift
//  JSONParserTests
//
//  Created by Wyatt on 9/26/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

import XCTest
@testable import JSONParser

class JSONParserTests: XCTestCase {
    
    let wmJSON = WMJSON()
    
     var retailViewController  = RetailersTableViewController()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

    /// There's a bug in XCODE 8. Not recognizing functions outside of the pre generated functions
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        

        let retail = wmJSON.loadFileFromBundle(WithfileName: "Retailers.json")
        
        
        XCTAssertNotNil(retail, "Retail JSON file is null. Please check if routine or file has been modified.")
        
        
     
        let offers = wmJSON.loadFileFromBundle(WithfileName: "Offers.json")
        
        XCTAssertNotNil(offers, "Offers JSON file is null. Please check if routine or file has been modified.")
        
        
        
        
        
        let tup = wmJSON.loadRetail()
        
        
        if let arr = tup.0 {
            
            
            XCTAssertNotNil(arr, "Please check search array. If search array is null")
            
            
            
            
        }
        
        
       
        
        
        
        retailViewController.viewDidLoad()
        
        
        
        
        let TE = retailViewController.tableElements
        
        var TableKeyTest = Array(TE!.keys)
        
        TableKeyTest.sort()
       
        
        var i = 0 ;
        for k in (retailViewController.keys) {
            
            let key = TableKeyTest[i]

            XCTAssertEqual(key, k, "Keys are not in alphbetically in order")
            
            
            i += 1
        }
        
        
        
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
