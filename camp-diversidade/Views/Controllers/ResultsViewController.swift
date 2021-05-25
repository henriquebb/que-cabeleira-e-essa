//
//  ResultsViewController.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 25/05/21.
//

import UIKit

protocol ResultsPresenting: AnyObject {
    
}

class ResultsViewController: UIViewController {
    
    var resultsPresenter = ResultsPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension ResultsViewController:  ResultsPresenting {
    
}

extension ResultsViewController {
    @IBAction func goToTabBar(_ sender: UIButton) {
        resultsPresenter.pushToTabBar()
    }
}
