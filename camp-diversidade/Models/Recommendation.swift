//
//  Recommendation.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 24/05/21.
//

import UIKit

class Recommendation {
    var image: UIImage?
    var title: String?
    var description: String?
    var type: String?
    
    init(image: UIImage?, title: String?, description: String?, type: String?) {
        self.image = image
        self.title = title
        self.description = description
        self.type = type
    }
}
