//
//  OnboardingPresenter.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 24/05/21.
//

import Foundation

protocol OnboardingDelegate: AnyObject {
    func pushToQuizz()
}

class OnboardingPresenter {
    
    weak var view: OnboardingPresenting?
    public var coordinator: AppCoordinator?
    
    init() {
        //load
    }
    
    func attachView(_ view: OnboardingPresenting) {
        self.view = view
    }
}

extension OnboardingPresenter: OnboardingDelegate  {
    func pushToQuizz() {
        coordinator?.showQuizz()
    }
}
