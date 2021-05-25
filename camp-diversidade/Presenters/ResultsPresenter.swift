//
//  ResultsPresenter.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 25/05/21.
//

import Foundation

protocol ResultsDelegate: AnyObject {
    func pushToTabBar()
}

class ResultsPresenter {
    
    weak var view: ResultsPresenting?
    public var coordinator: AppCoordinator?
    
    init() {
        //load
    }
    
    func attachView(_ view: ResultsPresenting) {
        self.view = view
    }
}

extension ResultsPresenter: ResultsDelegate  {
    
    func pushToTabBar() {
        coordinator?.showTabBar()
    }
}
