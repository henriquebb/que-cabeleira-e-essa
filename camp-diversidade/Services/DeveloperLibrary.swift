//
//  DeveloperLibrary.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 26/05/21.
//

import UIKit

class DeveloperLibrary {
    
    var developers: [Developer]
    
    init() {
        developers = []
    }
    
    func addDevelopers() {
        developers.append(Developer(title: "Bárbara",
                                    position: "Scrum Master",
                                    description: "Eu sou a Bárbara! Tenho 21 anos e estudo Engenharia Química, na UFSM, no Rio Grande do Sul. Meu cabelo é cacheado e demorei muuuito até aceitar minha própria pluralidade. Fico imensamente feliz em poder contribuir com um projeto que irá ajudar muitas outras pessoas que tenham uma história similar a minha!", image: UIImage(named: "barbara")))
        developers.append(Developer(title: "Dandara",
                                    position: "Desenvolvedora Front-End",
                                    description: "Oi! Meu nome é Dandara Estrela, faço Ciência da Computação na UFPB e sempre fui apaixonada por tecnologia. Hoje meu coração pertence ao desenvolvimento front-end e ao design, sempre tentando criar a melhor experiência de usabilidade para o usuário.",
                                    image: UIImage(named: "dandara")))
        developers.append(Developer(title: "Fabrício",
                                    position: "Desenvolvedor Back-End",
                                    description: "Tenho 24 anos, estou cursando Análise e Desenvolvimento de Sistemas. No meu tempo livre gosto de assistir seriados de investigação criminal.",
                                    image: UIImage(named: "fabricio")))
        developers.append(Developer(title: "Henrique",
                                    position: "Desenvolvedor iOS",
                                    description: "Tenho 30 anos, sou de BH e estou cursando Ciência da Computação na UFMG. Adoro passar a madrugada olhando modelos meteorológicos.",
                                    image: UIImage(named: "henrique")))
        developers.append(Developer(title: "Rodrigo",
                                    position: "Mentor de projeto",
                                    description: "Atuo como Scrum Master na ioasys. Sou formado em Ciência da Computação, com graduação e pós graduação, pela Universidade Federal de Lavras e Gerenciamento de projetos pela Fundação Getulio Vargas.",
                                    image: UIImage(named: "rodrigo")))
        developers.append(Developer(title: "Sarah",
                                    position: "UX/UI Designer",
                                    description: "Olá! Tenho 20 anos e sou do Amazonas, atualmente curso Design na UFAM e de vez em quando programo uma coisinha ou outra. Adoro cozinhar e comer aquele kikão no final da tarde, além de ser uma completa curiosa pelo mundo animal.",
                                    image: UIImage(named: "sarah")))
    }
}
