//
//  QuizzPresenter.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 19/05/21.
//

import Foundation

protocol QuizzDelegate: AnyObject {
    func getQuizzes()
    func signup()
}

class QuizzPresenter {
    weak var view: QuizzPresenting?
    public var coordinator: AppCoordinator?
    
    init() {
        //load
    }
    
    func attachView(_ view: QuizzPresenting) {
        self.view = view
    }
}

// MARK: - QuizzDelegate methods

extension QuizzPresenter: QuizzDelegate {
    
    func pushToResults() {
        coordinator?.instantiateResultsVC()
    }
    
    func getQuizzes() {
        let quizzLibrary = QuizzLibrary()
        quizzLibrary.addDummyQuizzes()
        view?.setQuizzes(quizzLibrary.quizzes)
    }
    func signup() {
//        let url = Endpoint(withPath: Path.signup)
//        let header = ["content-type": "application/json"]
//        let body = UserPreferences(
//            curvaturaCabelo: <#T##Int#>,
//            situacaoCabelo: <#T##Int#>,
//            temAlisamento: <#T##Bool#>,
//            temTintura: <#T##Bool#>,
//            temDescoloracao: <#T##Bool#>,
//            temCaspa: <#T##Bool#>,
//            temQueda: <#T##Bool#>,
//            temFiosElasticos: <#T##Bool#>,
//            produtoEhVegano: <#T##Bool#>,
//            produtoEhCrueltyfree: <#T##Bool#>,
//            produtoEhNoPooLowPoo: <#T##Bool#>,
//            produtoNaoTemParabenoESimilares: <#T##Bool#>,
//            produtoEhNatural: <#T##Bool#>,
//            produtoEhAntiqueda: <#T##Bool#>,
//            produtoEhAntifrizz: <#T##Bool#>,
//            produtoEhAntinos: <#T##Bool#>,
//            produtoDahBrilho: <#T##Bool#>,
//            produtoDahMaciez: <#T##Bool#>,
//            produtoDahHidratacao: <#T##Bool#>,
//            produtoDahDefinicao: <#T##Bool#>,
//            produtoDahCrescimento: <#T##Bool#>,
//            produtoDahVolume: <#T##Bool#>,
//            produtoControlaOleosidade: <#T##Bool#>,
//            produtoControlaVolume: <#T##Bool#>)
//        network.request(url: url, method: .POST, header: header, body: <#T##Data?#>, completion: <#T##(Data, HTTPURLResponse) -> Void#>)
    }
}
