//
//  TransactionListProvider.swift
//  ASBInterviewExercise
//
//  Created by Chao on 31/07/22.
//

import Foundation

protocol TransactionListProviderDelegate: AnyObject {
    func startFetching()
    func finishFetching()
    func transactionListLoaded(transactios: [Transaction])
    func transactionListFailed(error: Error)
}

class TransactionListProvider {
    weak var delegate: TransactionListProviderDelegate?
    
    private let listUrl = "https://gist.githubusercontent.com/Josh-Ng/500f2716604dc1e8e2a3c6d31ad01830/raw/4d73acaa7caa1167676445c922835554c5572e82/test-data.json"
    private let restClient: RestClientProtocol
    private var sessionTask: URLSessionTask?
    
    init(restClient: RestClientProtocol = RestClient()) {
        self.restClient = restClient
    }
    
    func fetchTransactionList() {
        delegate?.startFetching()
        guard let url = URL(string: listUrl) else {
            delegate?.finishFetching()
            // url error
            delegate?.transactionListFailed(error: NSError())
            return
        }
        sessionTask = restClient.apiRequest(URLRequest(url: url)) { [weak self] data, response, err in
            guard let self = self else {
                return
            }
            self.delegate?.finishFetching()
            
            guard err == nil else {
                self.delegate?.transactionListFailed(error: err!)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                self.delegate?.transactionListFailed(error: NSError())
                return
            }
            
            guard let data = data else {
                self.delegate?.transactionListLoaded(transactios: [])
                return
            }
            
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            if let transactions = try? decoder.decode([Transaction].self, from: data) {
                self.delegate?.transactionListLoaded(transactios: transactions)
            } else {
                // parse error
                self.delegate?.transactionListFailed(error: NSError())
            }
        }
    }
}
