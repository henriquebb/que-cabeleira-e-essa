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
    @IBOutlet weak var recommendationFilterItems: UICollectionView! {
        didSet {
            recommendationFilterItems.delegate = self
            recommendationFilterItems.dataSource = self
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            recommendationFilterItems.collectionViewLayout = layout
            recommendationFilterItems.showsHorizontalScrollIndicator = false
            recommendationFilterItems.backgroundColor = .clear
        }
    }
    @IBOutlet weak var categoriesStackView: UIStackView!
    @IBOutlet weak var shadowView: UIView!
    
    //Variables
    
    private var recommendationLibrary: RecommendationLibrary?
    private var recommendations: [Recommendation] = []
    private var tips: [Tip] = []
    private var products: [Product] = []
    private var selectedFilterItems: [(Bool)] = []
    private var lastCategoryIndexSelected = -1
    private var lastFilterIndexSelected = -1
    private var viewWillReload = true
    public var recommendationPresenter = RecommendationPresenter()
    
//MARK: - Lyfe Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        viewWillReload ? setup() : nil
        viewWillReload = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadowToFilterCollectionView()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { [self] _ in
            addShadowToFilterCollectionView()
        }
    }
}

//MARK: - Setup

extension RecommendationViewController {
    
    private func setup() {
        setupRecommendations()
        setupRecommendationView()
        setupCategoryStackViewItems()
        configureStackViewTouch()
    }
    
    private func setupRecommendationView() {
        navigationController?.navigationBar.isHidden = true
        lastCategoryIndexSelected = 0
        lastFilterIndexSelected = 0
        selectedFilterItems = Array(repeating: false, count: ProductCategories.allCases.count)
        selectedFilterItems[0] = true
    }
    
    private func setupCategoryStackViewItems() {
        let view = categoriesStackView.subviews.first
        let tipsLabel = categoriesStackView.subviews.last as? UILabel
        let label = view as? UILabel
        Filter.configureSelectedCategoryButton(label)
        Filter.configureDeselectedCategoryButton(tipsLabel)
        
    }
    
    private func setupRecommendations() {
        recommendationPresenter.attachView(self)
        !recommendationPresenter.isQuizzSubmited ? recommendationPresenter.getProducts(productsCategories: [], isPersonalized: UserDefaults.standard.bool(forKey: "quizz")) : nil
        recommendationFilterItems.reloadData()
    }
    
    private func registerTableViewCells() -> String {
        let nibName = "RecommendationTableViewCell"
        let nib = UINib(nibName: nibName, bundle: Bundle(for: RecommendationTableViewCell.self))
        recommendationTableView.register(nib, forCellReuseIdentifier: nibName)
        return nibName
    }
    
    private func setupNavigationBarTitle() {
        self.navigationController?.navigationBar.topItem?.title = " "
    }
}

//MARK: - UI

extension RecommendationViewController {
    private func addShadowToFilterCollectionView() {
        let shadowPath = UIBezierPath(roundedRect: shadowView.bounds, cornerRadius: 28)
        shadowView.layer.shadowPath = shadowPath.cgPath
        shadowView.layer.shadowRadius = 28
        shadowView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        shadowView.layer.shadowOpacity = 1
    }
}

//MARK: - TableView Cells

extension RecommendationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lastCategoryIndexSelected == RecommendationCategories.tips.rawValue ? tips.count : products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let nibName = registerTableViewCells()
        guard let cell = tableView.dequeueReusableCell(withIdentifier: nibName) as? RecommendationTableViewCell else {
            return RecommendationTableViewCell()
        }
        setCellsCategory(cell, indexPath)
        cell.layoutSubviews()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if lastCategoryIndexSelected == RecommendationCategories.products.rawValue {
            setupNavigationBarTitle()
            recommendationPresenter.setProductSelected(product: products[indexPath.item])
            recommendationPresenter.coordinator?.instanstiateProductDescriptionModal()
        }
    }
}

//MARK: - TableView Services

extension RecommendationViewController {
    private func setCellsCategory(_ cell: RecommendationTableViewCell, _ indexPath: IndexPath) {
        lastCategoryIndexSelected == RecommendationCategories.tips.rawValue ?
            cell.setupTipsCells(tip: tips[indexPath.item]) :
            cell.setupCells(product: products[indexPath.item])
    }
}

//MARK: - Touch Gestures

extension RecommendationViewController {
    
    private func configureStackViewTouch() {
        let touch = UITapGestureRecognizer(target: self, action: #selector(handleTouch(_:)))
        categoriesStackView.addGestureRecognizer(touch)
    }
    
    @objc private func handleTouch(_ sender: UITapGestureRecognizer) {
        for (index,view) in categoriesStackView.subviews.enumerated() {
            let label = view as? UILabel
            let location = sender.location(in: view)
            label?.hitTest(location, with: nil) != nil ? setupCategory(label, index) : nil
        }
    }
}

//MARK: - Touch Services

extension RecommendationViewController {
    private func setSelectedFilterItemsSize(_ index: Int) {
        let size = index == RecommendationCategories.products.rawValue ?
            ProductCategories.allCases.count : TipsCategories.allCases.count
        selectedFilterItems = Array(repeating: false, count: size)
        selectedFilterItems[0] = true
    }
    
    private func setupCategory(_ label: UILabel?, _ index: Int) {
        let lastLabel = categoriesStackView.subviews[lastCategoryIndexSelected] as? UILabel
        Filter.configureDeselectedCategoryButton(lastLabel)
        Filter.configureSelectedCategoryButton(label)
        reloadIfNeeded(index: index)
        setSelectedFilterItemsSize(index)
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

//MARK: - Networking

extension RecommendationViewController {
    
    func reloadIfNeeded(index: Int) {
        if lastCategoryIndexSelected != index {
            lastCategoryIndexSelected = index
            let isQuizzAnswered = UserDefaults.standard.bool(forKey: "quizz")
            getItems(index, isQuizzAnswered)
        }
    }
    
    private func getItems(_ index: Int, _ isQuizzAnswered: Bool) {
        index == RecommendationCategories.products.rawValue ?
            recommendationPresenter.getProducts(productsCategories: [],
                                                isPersonalized: isQuizzAnswered) :
            recommendationPresenter.getTips(tipsCategories: [],
                                            isPersonalized: isQuizzAnswered)
    }
}

//MARK: - FilterCollectionView

extension RecommendationViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lastCategoryIndexSelected == RecommendationCategories.products.rawValue ?
            ProductCategories.allCases.count : TipsCategories.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterCollectionViewCell", for: indexPath) as? FilterCollectionViewCell else { return FilterCollectionViewCell() }
        setFilterItemText(cell, indexPath)
        styleFilterItemCell(indexPath, cell)
        return cell
    }
}

//MARK: - FilterCollectionView Services

extension RecommendationViewController {
    private func setFilterItemText(_ cell: FilterCollectionViewCell, _ indexPath: IndexPath) {
        if !UserDefaults.standard.bool(forKey: "quizz") && indexPath.item == 0 {
            cell.filterName.text = "Gerais"
            return
        }
        cell.filterName.text = lastCategoryIndexSelected == RecommendationCategories.products.rawValue ? ProductCategories.allCases[indexPath.item].rawValue : TipsCategories.allCases[indexPath.item].rawValue
    }
    
    private func styleFilterItemCell(_ indexPath: IndexPath, _ cell: FilterCollectionViewCell) {
        selectedFilterItems[indexPath.item] ? cell.styleSelectedFilter() : cell.styleUnselectedFilter()
    }
    
    private func styleUnselectedFirstFilterItem() {
        let indexPath = IndexPath(row: 0, section: 0)
        let personalizedCell = recommendationFilterItems.cellForItem(at: indexPath) as? FilterCollectionViewCell
        personalizedCell?.styleUnselectedFilter()
        selectedFilterItems[indexPath.item] = false
    }
    
    private func styleUnselectedFilterItems(_ collectionView: UICollectionView) {
        for case let cell as FilterCollectionViewCell in collectionView.visibleCells {
            cell.styleUnselectedFilter()
        }
        selectedFilterItems = selectedFilterItems.map { _ in false }
    }
    
    private func checkIfSelectedFilterItemIsFirst(_ indexPath: IndexPath, _ collectionView: UICollectionView) {
        indexPath.item != 0 ? styleUnselectedFirstFilterItem() : styleUnselectedFilterItems(collectionView)
    }
    
    private func checkIfFilterItemIsSelected(_ indexPath: IndexPath, _ collectionView: UICollectionView, _ cell: FilterCollectionViewCell?) {
        if !selectedFilterItems[indexPath.item] {
            checkIfSelectedFilterItemIsFirst(indexPath, collectionView)
            cell?.styleSelectedFilter()
        }
        else { cell?.styleUnselectedFilter() }
    }
    
    private func getProducts() {
        recommendationPresenter.getProducts(productsCategories: selectedFilterItems.indices.filter({ (item) -> Bool in
            return selectedFilterItems[item]
        }).map({ (item) -> ProductCategories in
            return ProductCategories.allCases[item]
        }), isPersonalized: false)
    }
    
    private func checkIfIsFirstFilterItem() {
        
    }
    
    private func getProductsFilterItems(_ indexPath: IndexPath) {
        if indexPath.item == 0 && !selectedFilterItems[indexPath.item] {
            recommendationPresenter.getProducts(productsCategories: [], isPersonalized: false)
        } else if indexPath.item == 0 {
            recommendationPresenter.getProducts(productsCategories: [], isPersonalized: UserDefaults.standard.bool(forKey: "quizz"))
        } else {
            getProducts()
        }
    }
    
    private func getTips() {
        recommendationPresenter.getTips(tipsCategories: selectedFilterItems.indices.filter({ (item) -> Bool in
            return selectedFilterItems[item]
        }).map({ (item) -> TipsCategories in
            return TipsCategories.allCases[item]
        }), isPersonalized: false)
    }
    
    private func getTipsFilterItems(_ indexPath: IndexPath) {
        if indexPath.item == 0 && !selectedFilterItems[indexPath.item] {
            recommendationPresenter.getTips(tipsCategories: [], isPersonalized: false)
        } else if indexPath.item == 0 {
            recommendationPresenter.getTips(tipsCategories: [], isPersonalized: UserDefaults.standard.bool(forKey: "quizz"))
        } else {
            getTips()
        }
    }
    
    private func getFilterItems(_ indexPath: IndexPath) {
        lastCategoryIndexSelected == RecommendationCategories.products.rawValue ?
            getProductsFilterItems(indexPath) : getTipsFilterItems(indexPath)
    }
}

//MARK: - FilterCollectionView Selection

extension RecommendationViewController {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? FilterCollectionViewCell
        checkIfFilterItemIsSelected(indexPath, collectionView, cell)
        selectedFilterItems[indexPath.item].toggle()
        getFilterItems(indexPath)
    }
}

//MARK: - FilterCollectionViewFlowLayout

extension RecommendationViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var text = ""
        
        text = lastCategoryIndexSelected == RecommendationCategories.products.rawValue ? ProductCategories.allCases[indexPath.item].rawValue : TipsCategories.allCases[indexPath.item].rawValue
        
        if !UserDefaults.standard.bool(forKey: "quizz") && indexPath.item == 0 {
            text = "Gerais"
        }
        let resultText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)])
        let textWidth = resultText.boundingRect(with: resultText.size(), options: .usesLineFragmentOrigin, context: nil).width
        return CGSize(width: ceil(textWidth) + 16, height: 30)
    }
}

