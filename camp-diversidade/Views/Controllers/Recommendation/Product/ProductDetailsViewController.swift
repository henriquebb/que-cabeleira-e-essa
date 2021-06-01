//
//  ProductDetailsViewController.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 24/05/21.
//

import UIKit
import Kingfisher

protocol ProductDetailsPresenting: AnyObject {
    func setProductDescription(product: Product)
}

class ProductDetailsViewController: UIViewController {

    //IBOutlets
    
    @IBOutlet weak var productType: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productTitle: UILabel!
    @IBOutlet weak var productTypeView: UIView!
    @IBOutlet weak var productSubmitButtonView: UIView!
    @IBOutlet weak var productImage: UIImageView!
    
    //Variables
    
    var recommendationPresenter: RecommendationPresenter?
    var productURL: String = ""
    
//MARK: - Lyfe Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureProductDetailsViews()
        styleProductDetailsView()
        recommendationPresenter?.attachProductDetailsView(self)
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

//MARK: - Set Production Description

extension ProductDetailsViewController: ProductDetailsPresenting {
    func setProductDescription(product: Product) {
        productTitle.text = product.nome
        productDescription.text = product.descricao
        productType.text = product.tipo
        productURL = product.link
        let url = URL(string: product.imagem)
        productImage.kf.setImage(with: url)
    }
}

extension  ProductDetailsViewController {
    @IBAction func findProduct(_ sender: UIButton) {
        guard let url = URL(string: productURL) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
