//
//  OnboardingPresenter.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 24/05/21.
//

import Foundation

protocol OnboardingDelegate: AnyObject {
    func pushToQuizz()
    func signup()
}

class OnboardingPresenter {
    
    weak var view: OnboardingPresenting?
    public var coordinator: AppCoordinator?
    var networking: Networking?
    
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
    func signup() {
        networking = Networking()
        guard let url = Endpoint(withPath: .signup).url else {
            return
        }
        
        let userPreferenceSetter = UserPreferenceSetter(answers: [:])
        let header = ["content-type": "application/json"]
    
        
        networking?.request(url: url, method: .POST, header: header, body: networking?.encodeToJSON(data: userPreferenceSetter.userPreference), completion: { (data, response) in
            guard let results = self.networking?.decodeFromJSON(type: Results.self, data: data) else {
                return
            }
            UserDefaults.standard.setValue(results.id, forKey: "id")
        })
    }
}
