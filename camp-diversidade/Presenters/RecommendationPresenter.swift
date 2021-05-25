//
//  RecommendationPresenter.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 24/05/21.
//

import UIKit

protocol RecommendationDelegate: AnyObject {
}

class RecommendationPresenter {
    
    weak var view: RecommendationPresenting?
    public var coordinator: AppCoordinator?
    
    init() {
        //load
    }
    
    func attachView(_ view: RecommendationPresenting) {
        self.view = view
    }
}

extension TabBarPresenter: RecommendationDelegate  {
}
