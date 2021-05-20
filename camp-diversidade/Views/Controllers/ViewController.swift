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
    @IBOutlet weak var skipButton: UIView!
    @IBOutlet weak var quizzCollectionView: UICollectionView!
    @IBOutlet weak var submitButton: UIButton!
    
    private let presenter = QuizzPresenter()
    var quizzes: [Quizz]  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCategoriesScrollView()
        configureSkipButton()
        configureQuizzCollectionView()
        configureSubmitButton()
        presenter.attachView(self)
    }
}

// MARK: - ScrollView

extension ViewController {
    fileprivate func configureCategoriesScrollView() {
        categoriesScrollView.showsHorizontalScrollIndicator = false
    }
}

// MARK: - Button

extension ViewController {
    fileprivate func configureSkipButton() {
        skipButton.backgroundColor = .clear
        skipButton.layer.borderWidth = 3
        skipButton.layer.cornerRadius = 19
        skipButton.layer.borderColor = UIColor(red: 0.744, green: 0.74, blue: 0.871, alpha: 1).cgColor
    }
    
    fileprivate func configureSubmitButton() {
        submitButton.layer.cornerRadius = 8
    }
}

// MARK: - Quizz Collection View

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let bundle = Bundle(for: QuizzItemCollectionViewCell.self)
        let nib = UINib(nibName: "QuizzItemCollectionViewCell", bundle: bundle)
        collectionView.register(nib, forCellWithReuseIdentifier: "QuizzItemCollectionViewCell")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuizzItemCollectionViewCell", for: indexPath)
        return cell
    }
    
    func configureQuizzCollectionView() {
        quizzCollectionView.delegate = self
        quizzCollectionView.dataSource = self
    }
}

// MARK: - Quizz Collection View UI

extension ViewController: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: 10, height: 115)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 4
//    }
//
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
//    }
}

// MARK: - QuizzPresenting

extension ViewController: QuizzPresenting {
    func setQuizzes(_ quizzes: [Quizz]) {
        self.quizzes = quizzes
    }
}

