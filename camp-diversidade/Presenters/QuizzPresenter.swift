//
//  QuizzPresenter.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 19/05/21.
//

import Foundation

protocol QuizzDelegate: AnyObject {
    func getQuizzes()
}

class QuizzPresenter {
    weak var view: QuizzPresenting?
    public var coordinator: AppCoordinator?
    
    init() {
        //load
    }
    
    func attachView(_ view: QuizzPresenting) {
        self.view = view
    }
}

// MARK: - QuizzDelegate methods

extension QuizzPresenter: QuizzDelegate {
    func getQuizzes() {
        let quizzLibrary = QuizzLibrary()
        quizzLibrary.addDummyQuizzes()
        view?.setQuizzes(quizzLibrary.quizzes)
    }
}
