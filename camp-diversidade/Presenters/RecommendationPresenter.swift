//
//  RecommendationPresenter.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 24/05/21.
//

import UIKit

protocol RecommendationDelegate: AnyObject {
    func getTips()
}

class RecommendationPresenter {
    
    weak var view: RecommendationPresenting?
    public var coordinator: AppCoordinator?
    public var tips: Tips?
    
    init() {
        //load
    }
    
    func attachView(_ view: RecommendationPresenting) {
        self.view = view
    }
}

extension RecommendationPresenter: RecommendationDelegate  {
    func getTips() {
        let networking = Networking()
        guard let url = Endpoint(withPath: Path.tips).url else {
            return
        }
        let header = ["content-type": "application/json"]
        networking.request(url: url, method: .GET, header: header, body: nil) { (data, response) in
            let urlResponse = response as HTTPURLResponse
            if self.switchResponseCode(response: urlResponse) == 200 {
                self.tips = networking.decodeFromJSON(type: Tips.self, data: data)
                guard let tipsResult = self.tips else {
                    return
                }
                self.view?.setTips(tips: tipsResult.data)
            }
        }
    }
    
    private func switchResponseCode(response: HTTPURLResponse) -> Int {
        switch response.statusCode {
        case 200...299:
            print("success")
        case 300...310:
            print("redirected")
        case 401...499:
            print("client_error")
        case 500...599:
            print("internal server error")
        default:
            print("unknown error")
            return -1
        }
        return response.statusCode
    }
}
