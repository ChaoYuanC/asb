//
//  ViewControllerPresenter.swift
//  ASBInterviewExercise
//
//  Created by Chao on 31/07/22.
//

import Foundation

protocol ViewControllerPresenterView: AnyObject {
    func showLoading()
    func hideLoading()
    func showList()
    func showError()
}

class ViewControllerPresenter {
    weak var view: ViewControllerPresenterView?
    private var provider: TransactionListProviderProtocol
    private var transactios = [Transaction]()
    
    init(provider: TransactionListProviderProtocol = TransactionListProvider()) {
        self.provider = provider
        self.provider.delegate = self
    }
    
    func startFetchingTransactions() {
        provider.fetchTransactionList()
    }
    
    func transactionsCount() -> Int {
        transactios.count
    }
    
    func transaction(with index: Int) -> Transaction? {
        guard index < transactios.count else {
            return nil
        }
        return transactios[index]
    }
}

extension ViewControllerPresenter: TransactionListProviderDelegate {
    func startFetching() {
        view?.showLoading()
    }
    
    func finishFetching() {
        view?.hideLoading()
    }
    
    func transactionListLoaded(transactios: [Transaction]) {
        self.transactios = sortList(transactios: transactios)
        view?.showList()
    }
    
    private func sortList(transactios: [Transaction]) -> [Transaction] {
        transactios.sorted { $0.transactionDate > $1.transactionDate }
    }
    
    func transactionListFailed(error: Error) {
        view?.showError()
    }
}
