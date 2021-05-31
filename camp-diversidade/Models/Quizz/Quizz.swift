//
//  Quizz.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 19/05/21.
//

import UIKit

class Quizz {
    let question: String
    let answers: [String]
    let images: [UIImage?]
    
    init(question: String, answers: [String], images: [UIImage?]) {
        self.question = question
        self.answers = answers
        self.images = images
    }
}
