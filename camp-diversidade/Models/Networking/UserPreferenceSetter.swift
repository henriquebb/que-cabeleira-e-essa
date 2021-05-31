//
//  UserPreferenceSetter.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 27/05/21.
//

import Foundation

class UserPreferenceSetter {
    var userPreference: UserPreferences
    typealias Answer = Dictionary<Int, [(Bool, IndexPath)]>
    typealias AnswerItems = [(Bool, IndexPath)]
    typealias AnswerItem = (Bool, IndexPath)
    init(answers: Answer) {
        userPreference = UserPreferences()
        guard var curvatura = answers[Categories.curvatura.rawValue] else { return }
        setCurvatura(&curvatura)
        guard let tipo = answers[Categories.tipo.rawValue] else { return }
        guard let quimica = answers[Categories.químicas.rawValue] else { return }
        guard let caracteristicas = answers[Categories.características.rawValue] else { return }
        guard let produtos = answers[Categories.produtos.rawValue] else { return }
        guard let objetivos = answers[Categories.objetivos.rawValue] else { return }
        
        userPreference = UserPreferences(
            curvaturaCabelo: filter(answers: curvatura),
            situacaoCabelo: filter(answers: tipo),
            temAlisamento: filterByAnswer(answers: quimica, item: QuizzChemistry.alisamento.rawValue),
            temTintura: filterByAnswer(answers: quimica, item: QuizzChemistry.tintura.rawValue),
            temDescoloracao: filterByAnswer(answers: quimica, item: QuizzChemistry.descoloracao.rawValue),
            temCaspa: filterByAnswer(answers: caracteristicas, item: QuizzFeatures.caspa.rawValue),
            temQueda: filterByAnswer(answers: caracteristicas, item: QuizzFeatures.quedaDosFios.rawValue),
            temFiosElasticos: filterByAnswer(answers: caracteristicas, item: QuizzFeatures.fiosElasticos.rawValue),
            produtoEhVegano: filterByAnswer(answers: produtos, item: QuizzProducts.veganos.rawValue),
            produtoEhCrueltyfree: filterByAnswer(answers: produtos, item: QuizzProducts.crueltyFree.rawValue),
            produtoEhNoPooLowPoo: filterByAnswer(answers: produtos, item: QuizzProducts.noPooLowPoo.rawValue),
            produtoSemParabenos: filterByAnswer(answers: produtos, item: QuizzProducts.semParabenos.rawValue),
            produtoEhNatural: filterByAnswer(answers: produtos, item: QuizzProducts.naturais.rawValue),
            produtoDahBrilho: filterByAnswer(answers: objetivos, item: QuizzObjetivos.brilho.rawValue),
            produtoDahMaciezHidratacao: filterByAnswer(answers: objetivos, item: QuizzObjetivos.maciezHidratacao.rawValue),
            produtoDahDefinicao: filterByAnswer(answers: objetivos, item: QuizzObjetivos.definicao.rawValue),
            produtoDahCrescimento: filterByAnswer(answers: objetivos, item: QuizzObjetivos.crescimentoDosFios.rawValue),
            produtoDahVolume: filterByAnswer(answers: objetivos, item: QuizzObjetivos.volume.rawValue),
            produtoControlaOleosidade: filterByAnswer(answers: objetivos, item: QuizzObjetivos.controleDaOleosidade.rawValue),
            produtoControlaVolume: filterByAnswer(answers: objetivos, item: QuizzObjetivos.controleDeVolume.rawValue))
    }
    
    func setCurvatura(_ answer: inout AnswerItems) {
        answer = answer.map { (tuple) -> AnswerItem in
            return tuple
        }
    }
    
    func filter(answers: AnswerItems) -> Int {
        guard let preference = answers.filter({ (tuple) -> Bool in
            return tuple.0
        }).first?.1.item else { return 0 }
        return preference
    }
    
    func filterByAnswer(answers: AnswerItems, item: Int) -> Bool {
        guard let preference = answers.filter({ (tuple) -> Bool in
            return tuple.1.item == item
        }).first?.0 else { return false }
        return preference
    }
}
