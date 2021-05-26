//
//  RecommendationViewController.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 24/05/21.
//

import UIKit
import Kingfisher

protocol RecommendationPresenting: AnyObject {
    func setTips(tips: [Tip])
    func setProducts(products: [Product])
}

class RecommendationViewController: UIViewController {
    
    //IBOutlets

    @IBOutlet weak var recommendationTableView: UITableView! {
        didSet {
            recommendationTableView.estimatedRowHeight = 200
            recommendationTableView.rowHeight = UITableView.automaticDimension
            recommendationTableView.separatorStyle = .none
            recommendationTableView.delegate = self
            recommendationTableView.dataSource = self
        }
    }
    @IBOutlet weak var productFilter: CategoriesScrollView!
    @IBOutlet weak var productFilterStackView: UIStackView!
    @IBOutlet weak var categoriesStackView: UIStackView!
    
    //Variables
    
    var recommendationLibrary: RecommendationLibrary?
    var recommendations: [Recommendation] = []
    var tips: [Tip] = []
    var products: [Product] = []
    var recommendationPresenter = RecommendationPresenter()
    var lastCategoryIndexSelected = -1
    var lastFilterIndexSelected = -1
    
//MARK: - Lyfe Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

//MARK: - Setup

extension RecommendationViewController {
    
    func setup() {
   
        setupRecommendations()
        setupProductFilterStackView()
        setupRecommendationView()
        configureFilterStackViewTouch()
        configureStackViewTouch()
        setupCategoryStackViewItems()
        styleFilterStackViewItems()
    }
    
    func setupRecommendationView() {
        self.navigationController?.navigationBar.isHidden = true
        lastCategoryIndexSelected = 0
        lastFilterIndexSelected = 0
    }
    
    func setupCategoryStackViewItems() {
        let view = categoriesStackView.subviews.first
        let label = view as? UILabel
        QuizzViewController.configureSelectedCategoryButton(label)
    }
    
    func setupProductFilterStackView() {
        productFilter.showsHorizontalScrollIndicator = false
    }
    
    func setupRecommendations() {
        recommendationPresenter.attachView(self)
        recommendationPresenter.getProducts()
    }
    
    func registerTableViewCells() -> String {
        let nibName = "RecommendationTableViewCell"
        let nib = UINib(nibName: nibName, bundle: Bundle(for: RecommendationTableViewCell.self))
        recommendationTableView.register(nib, forCellReuseIdentifier: nibName)
        return nibName
    }
    
    func setupNavigationBarTitle() {
        self.navigationController?.navigationBar.topItem?.title = " "
    }
}

//MARK: - TableView Cells

extension RecommendationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if lastCategoryIndexSelected == ProductCategories.tips.rawValue {
            return tips.count
        }
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let nibName = registerTableViewCells()
        guard let cell = tableView.dequeueReusableCell(withIdentifier: nibName) as? RecommendationTableViewCell else {
            return RecommendationTableViewCell()
        }
        if lastCategoryIndexSelected == ProductCategories.tips.rawValue {
            cell.setupTipsCells(tip: tips[indexPath.row])
        } else {
            cell.setupCells(product: products[indexPath.row])
        }
        cell.translatesAutoresizingMaskIntoConstraints = false
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        setupNavigationBarTitle()
        recommendationPresenter.coordinator?.instanstiateProductDescriptionModal()
    }
}

//MARK: - TableView Footer

extension RecommendationViewController {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
}

//MARK: - Touch Gestures

extension RecommendationViewController {
    
    private func configureStackViewTouch() {
        let touch = UITapGestureRecognizer(target: self, action: #selector(handleTouch(_:)))
        categoriesStackView.addGestureRecognizer(touch)
//        for _ in categoriesStackView.subviews {
//            //categoriesStatus.append(false)
//        }
    }
    
    private func configureFilterStackViewTouch() {
        let touch = UITapGestureRecognizer(target: self, action: #selector(handleFilterTouch(_:)))
        productFilterStackView.addGestureRecognizer(touch)
    }
    
    @objc private func handleFilterTouch(_ sender: UITapGestureRecognizer) {
        for (index,view) in productFilterStackView.subviews.enumerated() {
            let location = sender.location(in: view)
            if (view.hitTest(location, with: nil)) != nil {
                styleUnselectedFilter(view: productFilterStackView.subviews[lastFilterIndexSelected])
                styleSelectedFilter(view: view)
                lastFilterIndexSelected = index
                //let lastView = categoriesStackView.subviews[lastCategoryIndexSelected] as? UILabel
                //categoriesStatus[index].toggle()
            }
        }
            
    }
    
    @objc private func handleTouch(_ sender: UITapGestureRecognizer) {
        for (index,view) in categoriesStackView.subviews.enumerated() {
            let label = view as? UILabel
            let location = sender.location(in: view)
            if (view.hitTest(location, with: nil) as? UILabel) != nil {
                let lastView = categoriesStackView.subviews[lastCategoryIndexSelected] as? UILabel
                QuizzViewController.configureDeselectedCategoryButton(lastView)
                QuizzViewController.configureSelectedCategoryButton(label)
                checkReload(index: index)
                checkCategory(index: index)
                //let lastView = categoriesStackView.subviews[lastCategoryIndexSelected] as? UILabel
                //categoriesStatus[index].toggle()
            }
        }
    }
}

//MARK: - RecommendationPresenting

extension RecommendationViewController: RecommendationPresenting {
    
    func setTips(tips: [Tip]) {
        self.tips = tips
        recommendationTableView.reloadData()
    }
    
    func setProducts(products: [Product]) {
        self.products = products
        recommendationTableView.reloadData()
    }
}

//MARK: - UI

extension RecommendationViewController {
    
    func styleSelectedFilter(view: UIView) {
        let label = view.subviews.first as? UILabel
        view.backgroundColor = UIColor(red: 0.316, green: 0.305, blue: 0.871, alpha: 0.15)
        view.layer.borderWidth = 0
        label?.textColor = UIColor(red: 0.316, green: 0.305, blue: 0.871, alpha: 1)
    }
    
    func styleUnselectedFilter(view: UIView) {
        view.backgroundColor = UIColor.clear
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
        let lastLabel = view.subviews.first as? UILabel
        lastLabel?.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
    }
    
    func styleFilterStackViewItems() {
        for (index, view) in productFilterStackView.subviews.enumerated(){
            view.layer.cornerRadius = 15
            styleUnselectedFilter(view: view)
            if index == 0 {
                styleSelectedFilter(view: view)
            }
        }
    }
}

//MARK: - Presenter Networking

extension RecommendationViewController {
    func checkCategory(index: Int) {
        if index == ProductCategories.tips.rawValue {
            recommendationPresenter.getTips()
        } else {
            recommendationPresenter.getProducts()
        }
    }
    
    func checkReload(index: Int) {
        if lastCategoryIndexSelected != index {
            lastCategoryIndexSelected = index
            recommendationTableView.reloadData()
        }
    }
}

