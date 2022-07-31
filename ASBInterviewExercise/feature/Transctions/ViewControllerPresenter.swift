//
//  ViewControllerPresenter.swift
//  ASBInterviewExercise
//
//  Created by Chao on 31/07/22.
//

import Foundation

protocol ViewControllerPresenterDelegate: AnyObject {
    func showLoading()
    func hideLoading()
    func showList()
    func showError()
}

class ViewControllerPresenter {
    
    func startFetchingTransactions() {
        
    }
}
