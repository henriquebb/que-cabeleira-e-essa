//
//  RecommendationPresenter.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 24/05/21.
//

import UIKit
import Kingfisher

protocol RecommendationDelegate: AnyObject {
    func getTips(tipsCategories: [TipsCategories], isPersonalized: Bool)
    func getProducts(productsCategories: [ProductCategories], isPersonalized: Bool)
    func setProductSelected(product: Product)
}

class RecommendationPresenter {
    
    weak var view: RecommendationPresenting?
    weak var productView: ProductDetailsPresenting?
    public var coordinator: AppCoordinator?
    public var tips: Tips?
    public var products: Products?
    public var productSelected: Product?
    public var isQuizzSubmited: Bool = false
    let networking = Networking()
    
    init() {
        //load
    }
    
    func attachView(_ view: RecommendationPresenting) {
        self.view = view
    }
    
    func attachProductDetailsView(_ view: ProductDetailsPresenting) {
        productView = view
        guard let product = productSelected else {
            return
        }
        productView?.setProductDescription(product: product)
    }
}

extension RecommendationPresenter: RecommendationDelegate  {
    
    func setProductSelected(product: Product) {
        productSelected = product
    }
    
    func getTips(tipsCategories: [TipsCategories], isPersonalized: Bool) {
        
        guard var url = Endpoint(withPath: Path.userTips).url else {
            return
        }
        
        if !isPersonalized {
            guard let userURL = Endpoint(withPath: Path.tips).url else {
                return
            }
            var component = URLComponents(url: userURL, resolvingAgainstBaseURL: true)
            if tipsCategories.count != 0 {
                component?.queryItems = tipsCategories.map({ (tip) -> URLQueryItem in
                    return URLQueryItem(name: "\(tip)", value: "true")
                })
            }
            
            guard let componentURL = component?.url else {
                return
            }
            url = componentURL
        } else {
            if let id = UserDefaults.standard.string(forKey: "id") {
                url.appendPathComponent(id)
            }
        }
        
        networking.request(url: url, method: .GET, header: nil, body: nil) { (data, response) in
            let urlResponse = response as HTTPURLResponse
            if Networking.switchResponseCode(response: urlResponse) == 200 {
                self.tips = self.networking.decodeFromJSON(type: Tips.self, data: data)
                guard let tipsResult = self.tips else {
                    return
                }
                self.view?.setTips(tips: tipsResult.data)
            }
        }
    }
    
    func getProducts(productsCategories: [ProductCategories], isPersonalized: Bool) {
        guard var url = Endpoint(withPath: Path.userProducts).url else {
            return
        }
        if !isPersonalized {
            guard let userURL = Endpoint(withPath: Path.products).url else {
                return
            }
            url = userURL
            var component = URLComponents(url: url, resolvingAgainstBaseURL: true)
            if productsCategories.count != 0 {
                component?.queryItems = productsCategories.map({ (product) -> URLQueryItem in
                    return URLQueryItem(name: "\(product)", value: "true")
                })
            }
            
            guard let componentURL = component?.url else {
                return
            }
            url = componentURL
        } else {
            if let id = UserDefaults.standard.string(forKey: "id") {
                url.appendPathComponent(id)
            }
        }
        
            networking.request(url: url, method: .GET, header: nil, body: nil) { [weak self] (data, response) in
            let urlResponse = response as HTTPURLResponse
            if Networking.switchResponseCode(response: urlResponse) == 200 {
                self?.products = self?.networking.decodeFromJSON(type: Products.self, data: data)
                guard let productsResult = self?.products else {
                    return
                }
                self?.view?.setProducts(products: productsResult.data)
            }
        }
    }
}
