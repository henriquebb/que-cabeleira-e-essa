//
//  Quizzes.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 19/05/21.
//

import Foundation

class QuizzLibrary {
    
    var quizzes: [Quizz]
    
    init() {
        quizzes = []
        addDummyQuizzes()
    }
    
    func addDummyQuizzes() {
        quizzes.append(Quizz(question: "Qual a curvatura do seu cabelo?",
                             answers: ["1A", "1B", "1C",
                                       "2A", "2B", "2C",
                                       "3A", "3B", "3C",
                                       "4A", "4B", "4C"]))
        quizzes.append(Quizz(question: "Qual é o seu tipo de cabelo",
                             answers: ["Normal", "Seco", "Oleoso", "Misto"]))
        quizzes.append(Quizz(question: "Seu cabelo tem alguma dessas químicas?",
                             answers: ["Nenhuma", "Tintura", "Descoloração", "Alisamento"]))
        quizzes.append(Quizz(question: "Com qual situação você mais se identifica?",
                             answers: ["Nenhuma", "Dermatite", "Caspa",
                                       "Queda dos fios", "Corte químico", "Fios elásticos"]))
        quizzes.append(Quizz(question: "Prefiro produtos que sejam...",
                             answers: ["Adaptáveis ao meu cabelo", "Veganos", "Cruelty free",
                                       "Naturais", "No poo/Low poo", "Sem parabenos"]))
        quizzes.append(Quizz(question: "O que você deseja conseguir com cuidados regulares com o cabelo?",
                             answers: ["Brilho", "Maciez e Hidratação", "Definição",
                                       "Crescimento dos fios", "Controle da oleosidade", "Antifrizz",
                                       "Antiquebra", "Controle de volume", "Volume"]))
    }
}
