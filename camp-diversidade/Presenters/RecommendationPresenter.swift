//
//  RecommendationPresenter.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 24/05/21.
//

import UIKit
import Kingfisher

protocol RecommendationDelegate: AnyObject {
    func getTips()
    func getProducts()
}

class RecommendationPresenter {
    
    weak var view: RecommendationPresenting?
    public var coordinator: AppCoordinator?
    public var tips: Tips?
    public var products: Products?
    let networking = Networking()
    
    init() {
        //load
    }
    
    func attachView(_ view: RecommendationPresenting) {
        self.view = view
    }
}

extension RecommendationPresenter: RecommendationDelegate  {
    
    func getTips() {
        
        guard let url = Endpoint(withPath: Path.tips).url else {
            return
        }
        networking.request(url: url, method: .GET, header: nil, body: nil) { (data, response) in
            let urlResponse = response as HTTPURLResponse
            if self.switchResponseCode(response: urlResponse) == 200 {
                self.tips = self.networking.decodeFromJSON(type: Tips.self, data: data)
                guard let tipsResult = self.tips else {
                    return
                }
                self.view?.setTips(tips: tipsResult.data)
            }
        }
    }
    
    func getProducts() {
        guard let url = Endpoint(withPath: Path.products).url else {
            return
        }
        networking.request(url: url, method: .GET, header: nil, body: nil) { [weak self] (data, response) in
            let urlResponse = response as HTTPURLResponse
            if self?.switchResponseCode(response: urlResponse) == 200 {
                self?.products = self?.networking.decodeFromJSON(type: Products.self, data: data)
                guard let productsResult = self?.products else {
                    return
                }
                self?.view?.setProducts(products: productsResult.data)
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
