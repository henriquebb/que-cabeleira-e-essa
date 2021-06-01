//
//  ResultsPresenter.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 25/05/21.
//

import UIKit

protocol ResultsDelegate: AnyObject {
    func pushToTabBar()
    func getResults()
    func getUserData()
}

class ResultsPresenter {
    
    weak var view: ResultsPresenting?
    public var coordinator: AppCoordinator?
    var networking: Networking?
    var quizzPresenter: QuizzPresenter?
    
    init() {
        //load
    }
    
    func attachView(_ view: ResultsPresenting) {
        self.view = view
    }
}

extension ResultsPresenter: ResultsDelegate  {
    
    func getUserData() {
        networking = Networking()
        guard var url = Endpoint(withPath: .signup).url else {
            return
        }
        url = url.appendingPathComponent(UserDefaults.standard.string(forKey: "id") ?? "")
        
        networking?.request(url: url, method: .GET, header: ["content-type": "application/json"], body: nil, completion: { data, response in
            if Networking.switchResponseCode(response: response as HTTPURLResponse) == 200 {
                guard let results = self.networking?.decodeFromJSON(type: Results.self, data: data) else {
                    return
                }
                self.view?.setResult(result: results.texto)
            } else {
                print("error")
            }
        })
    }
    
    func getResults() {
        networking = Networking()
        guard let url = Endpoint(withPath: .signup).url else {
            return
        }
        
        guard let answers = quizzPresenter?.answers else {
            return
        }
        let userPreferenceSetter = UserPreferenceSetter(answers: answers)
        let header = ["content-type": "application/json"]
    
        
        networking?.request(url: url, method: .POST, header: header, body: networking?.encodeToJSON(data: userPreferenceSetter.userPreference), completion: { (data, response) in
            guard let results = self.networking?.decodeFromJSON(type: Results.self, data: data) else {
                return
            }
            UserDefaults.standard.setValue(results.id, forKey: "id")
            UserDefaults.standard.setValue(true, forKey: "quizz")
            self.view?.setResult(result: results.texto)
            
        })
    }
    
    func pushToTabBar() {
        coordinator?.showTabBar()
    }
}
