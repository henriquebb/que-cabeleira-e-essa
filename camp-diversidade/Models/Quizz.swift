//
//  Quizz.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 19/05/21.
//

import Foundation

class Quizz {
    let question: String
    let answers: [String]
    
    init(question: String, answers: [String]) {
        self.question = question
        self.answers = answers
    }
}
