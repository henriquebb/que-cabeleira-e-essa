//
//  ProductDetailsViewController.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 24/05/21.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    //IBOutlets
    
    @IBOutlet weak var productTypeView: UIView!
    @IBOutlet weak var productSubmitButtonView: UIView!

//MARK: - Lyfe Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureProductDetailsViews()
        styleProductDetailsView()
    }
    
    override func viewDidLayoutSubviews() {
        ButtonViewShadow.configureButtonViewShadow(button: productSubmitButtonView)
    }
}

//MARK: - UI

extension ProductDetailsViewController {
    func configureProductDetailsViews() {
        self.title = "Descrição do Produto"
        self.navigationController?.navigationBar.isHidden = false
        styleProductDetailsView()
    }
    
    func styleProductDetailsView() {
        productTypeView.layer.cornerRadius = 8
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
    }
}
