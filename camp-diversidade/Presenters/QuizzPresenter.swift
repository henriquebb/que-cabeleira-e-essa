//
//  QuizzPresenter.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 19/05/21.
//

import Foundation

protocol QuizzDelegate: AnyObject {
    func getQuizzes()
    func setAnswers(answers: Dictionary<Int, [(Bool, IndexPath)]>)
    func updateQuizz()
}

class QuizzPresenter {
    weak var view: QuizzPresenting?
    weak var recommendationPresenter: RecommendationPresenter?
    public var coordinator: AppCoordinator?
    var answers: Dictionary<Int, [(Bool, IndexPath)]> = [:]
    var networking: Networking?
    
    init() {
        //load
    }
    
    func attachView(_ view: QuizzPresenting) {
        self.view = view
    }
    
    func attachPresenter(presenter: RecommendationPresenter) {
        recommendationPresenter = presenter
    }
}

// MARK: - QuizzDelegate methods

extension QuizzPresenter: QuizzDelegate {
    
    func setAnswers(answers: Dictionary<Int, [(Bool, IndexPath)]>) {
        self.answers = answers
    }
    
    func pushToResults() {
        coordinator?.instantiateResultsVC()
    }
    
    func updateQuizz() {
        recommendationPresenter?.isQuizzSubmited = true
        networking = Networking()
        let userPreferences = UserPreferenceSetter(answers: answers)
        guard var url = Endpoint(withPath: .signup).url else {
            return
        }
        guard let id = UserDefaults.standard.string(forKey: "id") else {
            return
        }
        url.appendPathComponent(id)
        networking?.request(url: url,
                            method: .PUT,
                            header: ["content-type": "application/json"],
                            body: networking?.encodeToJSON(data: userPreferences.userPreference),
                            completion: { (data, response) in
                                if Networking.switchResponseCode(response: response as HTTPURLResponse) == 200 {
                                    print("success")
                                    self.recommendationPresenter?.isQuizzSubmited = false
                                    self.pushToResults()
                                } else {
                                    print("something went wrong in PUT user")
                                }
                            })
    }
    
    func getQuizzes() {
        let quizzLibrary = QuizzLibrary()
        quizzLibrary.addDummyQuizzes()
        view?.setQuizzes(quizzLibrary.quizzes)
    }
    static func signup(answers: Dictionary<Int, [(Bool, IndexPath)]>) {
        let networking = Networking()
        guard let url = Endpoint(withPath: .signup).url else {
            return
        }
        let userPreferenceSetter = UserPreferenceSetter(answers: answers)
        let header = ["content-type": "application/json"]
    
        networking.request(url: url, method: .POST, header: header, body: networking.encodeToJSON(data: userPreferenceSetter.userPreference), completion: { (data, response) in
            guard let results = networking.decodeFromJSON(type: Results.self, data: data) else {
                return
            }
            UserDefaults.standard.setValue(results.id, forKey: "id")
        })
    }
}
