//
//  ViewController.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 12/05/21.
//

import UIKit

protocol QuizzPresenting: AnyObject {
    func setQuizzes(_ quizzes: [Quizz])
}

class ViewController: UIViewController {

    @IBOutlet weak var categoriesScrollView: UIScrollView!
    @IBOutlet weak var categoriesStackView: UIStackView!
    @IBOutlet weak var skipButton: UIView!
    @IBOutlet weak var quizzCollectionView: UICollectionView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var submitButtonView: UIView!
    @IBOutlet weak var helpButton: UIButton!
    
    private let presenter = QuizzPresenter()
    var quizzes: [Quizz]  = []
    private var currentQuizz: Quizz?
    private var categoriesStatus: [Bool] = []
    private var lastCategoryIndexSelected: Int = -1
    private var selectedItems: [Bool] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Setup

extension ViewController {
    private func setup() {
        presenter.attachView(self)
        presenter.getQuizzes()
        configureStackViewTouch()
        configureCategoriesScrollView()
        configureSkipButton()
        configureQuizzCollectionView()
        configureSubmitButton()
        configureButtonView()
    }
}

// MARK: - ScrollView

extension ViewController {
    private func configureCategoriesScrollView() {
        categoriesScrollView.showsHorizontalScrollIndicator = false
    }
}

// MARK: - Button

extension ViewController {
    private func configureSkipButton() {
        skipButton.backgroundColor = .clear
        skipButton.layer.borderWidth = 3
        skipButton.layer.cornerRadius = 19
        skipButton.layer.borderColor = UIColor(red: 0.775, green: 0.771, blue: 1, alpha: 1).cgColor
    }
    
    private func configureSubmitButton() {
        submitButton.layer.cornerRadius = 8
    }
    
    private func configureButtonView() {
        
        submitButtonView.clipsToBounds = false
        submitButtonView.layer.masksToBounds = false

        let shadowPath0 = UIBezierPath(roundedRect: CGRect(
                                        x: submitButtonView.bounds.minX,
                                        y: submitButtonView.bounds.minY,
                                        width: submitButtonView.bounds.width,
                                        height: submitButtonView.bounds.height/2),
                                       cornerRadius: 0)
        submitButtonView.layer.shadowPath = shadowPath0.cgPath
        submitButtonView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        submitButtonView.layer.shadowOpacity = 1
        submitButtonView.layer.shadowRadius = 18
        submitButtonView.layer.shadowOffset = CGSize(width: 0, height: -5)
        submitButtonView.layer.bounds = submitButtonView.bounds
        submitButtonView.layer.position = submitButtonView.center
        self.view.bringSubviewToFront(submitButtonView)
    }
}

// MARK: - Quizz Collection View

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentQuizz?.answers.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: registerCollectionViewCell(), for: indexPath) as? QuizzItemCollectionViewCell
        cell?.quizzAnswer.text = currentQuizz?.answers[indexPath.item]
        configureDeselectedItem(cell)
        
        return cell ?? QuizzItemCollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 60)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            if let headerView = collectionView
                .dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: registerHeaderView(),
                    for: indexPath) as? QuizzQuestionHeaderCollectionReusableView {
            headerView.quizzQuestion.text = currentQuizz?.question
            headerView.quizzQuestion.sizeToFit()
            return headerView
            }
        default:
            assert(false)
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? QuizzItemCollectionViewCell
        if !selectedItems[indexPath.item] {
            configureSelectedItem(cell)
        } else {
            configureDeselectedItem(cell)
        }
        selectedItems[indexPath.item].toggle()
    }
    
    private func configureQuizzCollectionView() {
        quizzCollectionView.delegate = self
        quizzCollectionView.dataSource = self
        quizzCollectionView.showsVerticalScrollIndicator = false
        quizzCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        let view = categoriesStackView.subviews.first
        let label = view as? UILabel
        currentQuizz = quizzes[0]
        reloadCollectionView()
        configureSelectedCategoryButton(label)
        categoriesStatus[0].toggle()
    }
    
    private func reloadCollectionView() {
        currentQuizz?.answers.forEach { _ in selectedItems.append(false) }
        selectedItems = Array(repeating: false, count: currentQuizz?.answers.count ?? 0)
        quizzCollectionView.reloadData()
        quizzCollectionView.layoutIfNeeded()
    }
    
    private func deselectAllItems() {
        guard let selectedIndexes = quizzCollectionView.indexPathsForSelectedItems else {
            return
        }
        for itemIndex in selectedIndexes {
            quizzCollectionView.deselectItem(at: itemIndex, animated: false)
        }
    }
    
    private func registerCollectionViewCell() -> String {
        let name = "QuizzItemCollectionViewCell"
        let bundle = Bundle(for: QuizzItemCollectionViewCell.self)
        let nib = UINib(nibName: name, bundle: bundle)
        quizzCollectionView.register(nib, forCellWithReuseIdentifier: name)
        return name
    }
    
    private func registerHeaderView() -> String {
        let name = "QuizzQuestionHeaderCollectionReusableView"
        let bundle = Bundle(for: QuizzQuestionHeaderCollectionReusableView.self)
        let nib = UINib(nibName: name, bundle: bundle)
        quizzCollectionView.register(nib,
                                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                     withReuseIdentifier: name)
        return name
    }
}

// MARK: - Quizz Collection View UI

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    private func configureSelectedCategoryButton(_ label: UILabel?) {
        label?.textColor = UIColor.init(red: 0.015, green: 0, blue: 0.75, alpha: 1)
        label?.font = UIFont.systemFont(ofSize: label?.font.pointSize ?? 0, weight: .medium)
        label?.layoutIfNeeded()
    }
    
    private func configureDeselectedCategoryButton(_ label: UILabel?) {
        label?.textColor = UIColor.black
        label?.font = UIFont.systemFont(ofSize: label?.font.pointSize ?? 0, weight: .regular)
    }
    
    private func configureSelectedItem(_ cell: QuizzItemCollectionViewCell?) {
        let color = UIColor(red: 0.316, green: 0.305, blue: 0.871, alpha: 1)
        cell?.quizzAnswer.textColor = color
        cell?.quizzAnswer.font = UIFont.systemFont(ofSize: cell?.quizzAnswer.font.pointSize ?? 0, weight: .bold)
        cell?.quizzItemCollectionViewCellView.backgroundColor = color
    }
    
    private func configureDeselectedItem(_ cell:  QuizzItemCollectionViewCell?) {
        let color = UIColor(red: 0.992, green: 0.863, blue: 0.835, alpha: 1)
        cell?.quizzAnswer.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        cell?.quizzAnswer.font = UIFont.systemFont(ofSize: cell?.quizzAnswer.font.pointSize ?? 0, weight: .regular)
        cell?.quizzItemCollectionViewCellView.backgroundColor = color
    }
}

// MARK: - QuizzPresenting

extension ViewController: QuizzPresenting {
    func setQuizzes(_ quizzes: [Quizz]) {
        self.quizzes = quizzes
    }
}

// MARK: - StackView Touch

extension ViewController {
    private func configureStackViewTouch() {
        let touch = UITapGestureRecognizer(target: self, action: #selector(handleTouch(_:)))
        categoriesStackView.addGestureRecognizer(touch)
        for _ in categoriesStackView.subviews {
            categoriesStatus.append(false)
        }
    }
    
    @objc private func handleTouch(_ sender: UITapGestureRecognizer) {
        for (index,view) in categoriesStackView.subviews.enumerated() {
            let label = view as? UILabel
            let location = sender.location(in: view)
            if (view.hitTest(location, with: nil) as? UILabel) != nil {
                if lastCategoryIndexSelected != -1 {
                    let lastView = categoriesStackView.subviews[lastCategoryIndexSelected] as? UILabel
                    configureDeselectedCategoryButton(lastView)
                }
                currentQuizz = quizzes[index]
                deselectAllItems()
                reloadCollectionView()
                configureSelectedCategoryButton(label)
                categoriesStatus[index].toggle()
                lastCategoryIndexSelected = index
            }
        }
    }
}

