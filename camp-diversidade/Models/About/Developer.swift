//
//  Developer.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 26/05/21.
//

import UIKit

class Developer {
    let title: String
    let position: String
    let description: String
    let image: UIImage?
    
    init(title: String, position: String, description: String, image: UIImage?) {
        self.title = title
        self.position = position
        self.description = description
        self.image = image
    }
}
