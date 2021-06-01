//
//  ResultsViewController.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 25/05/21.
//

import UIKit

protocol ResultsPresenting: AnyObject {
    func setResult(result: Result)
}

class ResultsViewController: UIViewController {
    
    //IBOutlets
    
    @IBOutlet weak var resultImage: UIImageView!
    @IBOutlet weak var resultTitle: UILabel!
    @IBOutlet weak var resultDescription: UILabel!
    
    //Variables
    
    var resultsPresenter = ResultsPresenter()
    
//MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsPresenter.attachView(self)
        resultsPresenter.getResults()
//        if ((resultsPresenter.coordinator?.tabBarCurrentVC) != nil) {
//            resultsPresenter.getUserData()
//        } else {
//            resultsPresenter.getResults()
//        }
    }
}

//MARK: - ResultsPresenting

extension ResultsViewController:  ResultsPresenting {
    func setResult(result: Result) {
        resultTitle.text = switchCabeleira(result.tipoCurvatura)
        resultDescription.text = result.situacaoCabelo
        resultImage.image = UIImage(named: result.tipoCurvatura)
    }
}

//MARK: - Button Actions

extension ResultsViewController {
    @IBAction func goToTabBar(_ sender: UIButton) {
        resultsPresenter.pushToTabBar()
    }
}

//MARK: - General Services

extension ResultsViewController {
    func switchCabeleira(_ cabeleira: String) -> String {
        switch cabeleira {
        case "liso": return Cabeleira.liso.rawValue
        case "cacheado": return Cabeleira.cacheado.rawValue
        case "ondulado": return Cabeleira.ondulado.rawValue
        case "crespo": return Cabeleira.crespo.rawValue
        default:
            return Cabeleira.liso.rawValue
        }
    }
}
