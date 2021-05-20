//
//  QuizzPresenter.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 19/05/21.
//

import Foundation

protocol QuizzDelegate: AnyObject {
    func addQuizz()
}

class QuizzPresenter {
    weak var view: QuizzPresenting?
    
    init() {
        //load
    }
    
    func attachView(_ view: QuizzPresenting) {
        self.view = view
    }
}

extension QuizzPresenter: QuizzDelegate {
    func addQuizz() {
        let quizzLibrary = QuizzLibrary()
        view?.setQuizzes(quizzLibrary.quizzes)
    }
}
