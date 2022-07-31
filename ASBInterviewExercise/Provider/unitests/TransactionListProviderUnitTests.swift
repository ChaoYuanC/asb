//
//  TransactionListProviderUnitTests.swift
//  ASBInterviewExerciseTests
//
//  Created by Chao on 31/07/22.
//

import XCTest
@testable import ASBInterviewExercise

class MockRestClient: RestClientProtocol {
    var session: URLSession
    var error: NSError?
    var data: Data?
    var urlResponse: HTTPURLResponse?
    init() {
        session = URLSession(configuration: .default)
    }
    
    func apiRequest(_ request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionTask {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else  { return }
            completionHandler(self.data, self.urlResponse, self.error)
        }
        return session.dataTask(with: request)
    }
}


class MockTransactionListProviderDelegate: TransactionListProviderDelegate {
    var startFetch = false
    var finishFetch = false
    var transactios: [Transaction]?
    var failed = false
    var expectation: XCTestExpectation?
    
    func startFetching() {
        startFetch = true
    }
    
    func finishFetching() {
        finishFetch = true
    }
    
    func transactionListLoaded(transactios: [Transaction]) {
        self.transactios = transactios
        expectation?.fulfill()
    }
    
    func transactionListFailed(error: Error) {
        failed = true
        expectation?.fulfill()
    }
}

class TransactionListProviderUnitTests: XCTestCase {

    var mockRestClient = MockRestClient()
    var provider: TransactionListProvider!
    var mockDelegate = MockTransactionListProviderDelegate()
    override func setUp() {
        super.setUp()
        provider = TransactionListProvider(restClient: mockRestClient)
        provider.delegate = mockDelegate
    }

    func testTransactionListLoadedFailed_gvienError() throws {
        // Setup
        mockRestClient.error = NSError()
        let expectation = self.expectation(description: "loading")
        mockDelegate.expectation = expectation
        
        // Run
        provider.fetchTransactionList()
        
        // Verify
        waitForExpectations(timeout: 2) { error in
            XCTAssertNil(error)
            XCTAssertTrue(self.mockDelegate.startFetch)
            XCTAssertTrue(self.mockDelegate.finishFetch)
            XCTAssertNil(self.mockDelegate.transactios)
            XCTAssertTrue(self.mockDelegate.failed)
        }
    }
    
    func testTransactionListLoadedSuccess() throws {
        // Setup
        let string = "[{\"id\":1,\"transactionDate\":\"2021-08-31T15:47:10\",\"summary\":\"Activity 4 with Images\",\"debit\":9379.55,\"credit\":0}]"
        mockRestClient.data = string.data(using: .utf8)!
        mockRestClient.urlResponse = HTTPURLResponse(url: URL(string: "https://google.com")!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
        let expectation = self.expectation(description: "loading")
        mockDelegate.expectation = expectation
        
        // Run
        provider.fetchTransactionList()
        
        // Verify
        waitForExpectations(timeout: 2) { error in
            XCTAssertNil(error)
            XCTAssertTrue(self.mockDelegate.startFetch)
            XCTAssertTrue(self.mockDelegate.finishFetch)
            XCTAssertEqual(self.mockDelegate.transactios?.count, 1)
            XCTAssertFalse(self.mockDelegate.failed)
        }
    }
}
