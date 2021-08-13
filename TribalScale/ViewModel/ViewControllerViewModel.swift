//
//  ViewControllerViewModel.swift
//  TribalScale
//
//  Created by Jack Bordner on 8/13/21.
//

import Foundation

protocol ViewControllerViewModelDelegate: class {
    func didRetrieveData()
    func didRecieveError(error: Error)
}

class ViewControllerViewModel {
    
    weak var delegate: ViewControllerViewModelDelegate?
    public var data = [Article]()
    
    init() {
        retrieveData()
    }
    
    private func retrieveData() {
        NewsClientService().fetchsNewsArticles {  [weak self] (retrievedArticles, error)in
            
            guard error == nil else {
                self?.delegate?.didRecieveError(error: error!)
                return
            }
            
            self?.data = retrievedArticles
            self?.delegate?.didRetrieveData()
        }
    }
}
