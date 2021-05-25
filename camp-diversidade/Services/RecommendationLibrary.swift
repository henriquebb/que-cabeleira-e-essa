//
//  RecommendationLibrary.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 24/05/21.
//

import UIKit

class RecommendationLibrary {
    
    var recommendations: [Recommendation]
    
    init() {
        recommendations = []
    }
    
    func addDummyRecommendations() {
        recommendations.append(Recommendation(image: UIImage(named: "image1"), title: "Cocooil", description: "Recomendado para cabelos descoloridos com tintura e loiros", type: "Óleo leave-in"))
        recommendations.append(Recommendation(image: UIImage(named: "image2"), title: "Frontrow", description: "Recomendado para cabelos ressecados que necessitam de reposição de massa", type: "Shampoo"))
        recommendations.append(Recommendation(image: UIImage(named: "image3"), title: "Momshol", description: "Recomendado para cabelos opacos e sem brilho", type: "Condicionador"))
    }
}
