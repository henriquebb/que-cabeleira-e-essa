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

class QuizzViewController: UIViewController {

    @IBOutlet weak var categoriesScrollView: UIScrollView!
    @IBOutlet weak var categoriesStackView: UIStackView!
    @IBOutlet weak var quizzCollectionView: UICollectionView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var submitButtonView: UIView!
    @IBOutlet weak var categoriesScrollViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var skipButton: SkipButton!
    
    public let presenter = QuizzPresenter()
    var quizzes: [Quizz]  = []
    private var currentQuizz: Quizz?
    private var categoriesStatus: [Bool] = []
    private var lastCategoryIndexSelected: Int = -1
    private var selectedItems: [(Bool, IndexPath)] = []
    private var selectedQuizzAnswers = Dictionary<Int, [(Bool, IndexPath)]>()
    
// MARK: - Life Cycle of App
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addPaddingToCollectionView()
        ButtonViewShadow.configureButtonViewShadow(button: submitButtonView)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if presenter.coordinator?.tabBarCurrentVC == self {
            super.viewWillTransition(to: size, with: coordinator)
            coordinator.animate(alongsideTransition: nil) { [self] _ in
                addPaddingToCollectionView()
                ButtonViewShadow.configureButtonViewShadow(button: submitButtonView)
            }
        }
    }
}

// MARK: - Setup

extension QuizzViewController {
    private func setup() {
        presenter.attachView(self)
        presenter.getQuizzes()
        configureStackViewTouch()
        configureCategoriesScrollView()
        configureSkipButton()
        configureQuizzCollectionView()
        configureSubmitButton()
    }
}

// MARK: - ScrollView

extension QuizzViewController {
    private func configureCategoriesScrollView() {
        categoriesScrollView.showsHorizontalScrollIndicator = false
    }
}

// MARK: - Button

extension QuizzViewController {
    private func configureSkipButton() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(skipQuizz))
        skipButton.addGestureRecognizer(tap)
        skipButton.layer.borderColor = UIColor(red: 0.776, green: 0.769, blue: 1, alpha: 1).cgColor
        let label = skipButton.subviews.first as? UILabel
        label?.textColor = UIColor(red: 0.776, green: 0.769, blue: 1, alpha: 1)
    }
    
    private func configureSubmitButton() {
        submitButton.layer.cornerRadius = 8
    }
}

// MARK: - Quizz Collection View

extension QuizzViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return currentQuizz?.answers.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: registerCollectionViewCell(), for: indexPath) as? QuizzItemCollectionViewCell
        cell?.quizzAnswer.text = currentQuizz?.answers[indexPath.item]
        cell?.quizzAnswerImage.image = UIImage(named: cell?.quizzAnswer.text ?? "")
        if selectedItems[indexPath.item].0 {
            configureSelectedItem(cell)
        } else {
            configureDeselectedItem(cell)
        }
        
        return cell ?? QuizzItemCollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 70)
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
        if !selectedItems[indexPath.item].0 {
            if (lastCategoryIndexSelected == Categories.curvatura.rawValue
                    || lastCategoryIndexSelected == Categories.tipo.rawValue)
                && selectedQuizzAnswers[lastCategoryIndexSelected]?.count ?? 0 > 0 {
                return
            }
            selectedItems[indexPath.item].0 = true
            configureSelectedItem(cell)
        } else {
            guard let quizz = selectedQuizzAnswers[lastCategoryIndexSelected] else {
                return
            }
            collectionView.deselectItem(at: indexPath, animated: false)
            selectedQuizzAnswers[lastCategoryIndexSelected] = quizz.filter { $0.1 != indexPath }
            if selectedQuizzAnswers[lastCategoryIndexSelected]?.count == 0 {
                selectedQuizzAnswers.removeValue(forKey: lastCategoryIndexSelected)
            }
            configureDeselectedItem(cell)
            selectedItems[indexPath.item].0 = false
            checkQuizzIsAnswered()
            return
        }
        selectedItems[indexPath.item].1 = indexPath
        var array = selectedQuizzAnswers[lastCategoryIndexSelected] ?? []
        array.append((true, indexPath))
        selectedQuizzAnswers[lastCategoryIndexSelected] = array
        checkQuizzIsAnswered()
    }
    
    private func configureQuizzCollectionView() {
        quizzCollectionView.delegate = self
        quizzCollectionView.dataSource = self
        quizzCollectionView.showsVerticalScrollIndicator = false
        addPaddingToCollectionView()
        let view = categoriesStackView.subviews.first
        let label = view as? UILabel
        currentQuizz = quizzes[0]
        reloadCollectionView()
        QuizzViewController.configureSelectedCategoryButton(label)
        lastCategoryIndexSelected = 0
        categoriesStatus[0].toggle()
    }
    
    private func reloadCollectionView() {
        currentQuizz?.answers.forEach { _ in selectedItems.append((false, IndexPath())) }
        selectedItems.removeAll()
        selectedItems = Array(repeating: (false, IndexPath()), count: currentQuizz?.answers.count ?? 0)
        quizzCollectionView.reloadData()
        quizzCollectionView.layoutIfNeeded()
    }
    
    private func selectItems(at index: Int) {
        guard let answers = selectedQuizzAnswers[index] else {
            return
        }
        for (_,itemIndex) in answers {
            quizzCollectionView.selectItem(at: itemIndex, animated: false, scrollPosition: .centeredHorizontally)
            let cell = quizzCollectionView.cellForItem(at: itemIndex)
            configureSelectedItem(cell as? QuizzItemCollectionViewCell)
            selectedItems[itemIndex.item] = (true, itemIndex)
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
    
    func checkQuizzIsAnswered() {
        if selectedQuizzAnswers.count == categoriesStatus.count {
            submitButton.backgroundColor = UIColor(red: 0.316, green: 0.305, blue: 0.871, alpha: 1)
            submitButton.tintColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
            presenter.coordinator?.showTabBar()
        } else {
            submitButton.backgroundColor = UIColor(red: 0.959, green: 0.958, blue: 1, alpha: 1)
            submitButton.tintColor = UIColor(red: 0.316, green: 0.305, blue: 0.871, alpha: 1)
        }
    }
}

// MARK: - Quizz Collection View UI

extension QuizzViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    static func configureSelectedCategoryButton(_ label: UILabel?) {
        label?.textColor = UIColor.init(red: 0.015, green: 0, blue: 0.75, alpha: 1)
        label?.font = UIFont.systemFont(ofSize: label?.font.pointSize ?? 0, weight: .medium)
        label?.layoutIfNeeded()
    }
    
    static func configureDeselectedCategoryButton(_ label: UILabel?) {
        label?.textColor = UIColor.black
        label?.font = UIFont.systemFont(ofSize: label?.font.pointSize ?? 0, weight: .regular)
    }
    
    private func configureSelectedItem(_ cell: QuizzItemCollectionViewCell?) {
        let color = UIColor(red: 0.316, green: 0.305, blue: 0.871, alpha: 1)
        cell?.quizzAnswer.textColor = color
        cell?.quizzAnswer.font = UIFont.systemFont(ofSize: cell?.quizzAnswer.font.pointSize ?? 0, weight: .bold)
        cell?.quizzItemCollectionViewCellView.backgroundColor = color
        guard let imageName = cell?.quizzAnswer.text else {
            return
        }
        cell?.quizzAnswerImage.image = UIImage(named: "\(imageName)Selecionada")
        cell?.layoutIfNeeded()
    }
    
    private func configureDeselectedItem(_ cell:  QuizzItemCollectionViewCell?) {
        let color = UIColor(red: 0.992, green: 0.863, blue: 0.835, alpha: 1)
        cell?.quizzAnswer.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        cell?.quizzAnswer.font = UIFont.systemFont(ofSize: cell?.quizzAnswer.font.pointSize ?? 0, weight: .regular)
        cell?.quizzItemCollectionViewCellView.backgroundColor = color
        cell?.quizzAnswerImage.image = UIImage(named: cell?.quizzAnswer.text ?? "")
    }
    
    private func addPaddingToCollectionView() {
        self.quizzCollectionView.contentInset = UIEdgeInsets(top: 0, left: self.view.safeAreaInsets.left + 20, bottom: 0, right: self.view.safeAreaInsets.left + 20)
    }
}

// MARK: - QuizzPresenting

extension QuizzViewController: QuizzPresenting {
    func setQuizzes(_ quizzes: [Quizz]) {
        self.quizzes = quizzes
    }
}

// MARK: - Touch

extension QuizzViewController {
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
                let lastView = categoriesStackView.subviews[lastCategoryIndexSelected] as? UILabel
                QuizzViewController.configureDeselectedCategoryButton(lastView)
                currentQuizz = quizzes[index]
                reloadCollectionView()
                selectItems(at: index)
                QuizzViewController.configureSelectedCategoryButton(label)
                categoriesStatus[index].toggle()
                lastCategoryIndexSelected = index
            }
        }
    }
    
    @objc private func skipQuizz() {
        presenter.coordinator?.showTabBar()
    }
}

