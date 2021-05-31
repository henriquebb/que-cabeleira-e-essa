//
//  Recommendation.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 24/05/21.
//

import UIKit

class Recommendation {
    public var image: UIImage?
    public var title: String?
    public var description: String?
    public var type: String?
    
    init(image: UIImage?, title: String?, description: String?, type: String?) {
        self.image = image
        self.title = title
        self.description = description
        self.type = type
    }
}
