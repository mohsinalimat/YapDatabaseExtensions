//
//  PromiseKitTests.swift
//  YapDBExtensionsMobile
//
//  Created by Daniel Thorpe on 15/04/2015.
//  Copyright (c) 2015 Daniel Thorpe. All rights reserved.
//

import Foundation
import XCTest
import PromiseKit
import YapDatabase
import YapDatabaseExtensions
import YapDBExtensionsMobile

extension AsynchronousReadWriteTests {

    func test_ReadingAndWriting_Object_PromiseKit() {
        let db = createYapDatabase(__FILE__, suffix: __FUNCTION__)
        let expectation = expectationWithDescription("Finished async writing of object.")

        (db.asyncWrite(person) as PromiseKit.Promise<Person>).then { saved -> Void in
            validateWrite(saved, self.person, usingDatabase: db)
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5.0, handler: nil)
    }

    func test_ReadingAndWriting_Value_PromiseKit() {
        let db = createYapDatabase(__FILE__, suffix: __FUNCTION__)
        let expectation = expectationWithDescription("Finished async writing of value.")

        (db.asyncWrite(barcode) as PromiseKit.Promise<Barcode>).then { saved -> Void in
            validateWrite(saved, self.barcode, usingDatabase: db)
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5.0, handler: nil)
    }

    func test_ReadingAndWriting_ValueWithValueMetadata_PromiseKit() {
        let db = createYapDatabase(__FILE__, suffix: __FUNCTION__)
        let expectation = expectationWithDescription("Finished async writing of value with value metadata.")

        (db.asyncWrite(product) as PromiseKit.Promise<Product>).then { saved -> Void in
            validateWrite(saved, self.product, usingDatabase: db)
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5.0, handler: nil)
    }
}

extension AsynchronousRemoveTests {

    func test_RemovePersistable_PromiseKit() {
        let db = createYapDatabase(__FILE__, suffix: __FUNCTION__)
        let expectation = expectationWithDescription("Finished async writing of object.")

        db.write(barcode)
        XCTAssertEqual((db.readAll() as [Barcode]).count, 1, "There should be one barcodes in the database.")

        (db.asyncRemove(barcode) as PromiseKit.Promise<Void>).then { () -> Void in
            XCTAssertEqual((db.readAll() as [Barcode]).count, 0, "There should be no barcodes in the database.")
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5.0, handler: nil)
    }

    func test_RemovePersistables_PromiseKit() {
        let db = createYapDatabase(__FILE__, suffix: __FUNCTION__)
        let expectation = expectationWithDescription("Finished async writing of object.")

        let _people = people()
        db.write(_people)
        XCTAssertEqual((db.readAll() as [Person]).count, _people.count, "There should be \(_people.count) Person in the database.")

        (db.asyncRemove(_people) as PromiseKit.Promise<Void>).then { () -> Void in
            XCTAssertEqual((db.readAll() as [Person]).count, 0, "There should be no Person in the database.")
            expectation.fulfill()
        }

        waitForExpectationsWithTimeout(5.0, handler: nil)
    }

}
