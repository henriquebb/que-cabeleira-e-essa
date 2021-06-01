//
//  OnboardingViewController.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 22/05/21.
//

import UIKit

protocol OnboardingPresenting: AnyObject {
    
}

class OnboardingViewController: UIViewController {

    //IBOutlets
    
    @IBOutlet weak var welcomeScrollView: UIScrollView!
    @IBOutlet weak var welcomePageControl: UIPageControl!
    @IBOutlet weak var skipButton: SkipButton!
    
    //Views
    var slides: [OnboardingWelcomeView] = []
    var animation: UIViewPropertyAnimator?
    var scrollContentPageSubview: UIView = UIView()
    
    //CGFloat
    var leftPadding: CGFloat = 0
    var rightPadding: CGFloat = 0
    
    //presenter
    
    public let presenter = OnboardingPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
        configureScrollView()
        configureSkipButton()
        welcomePageControl.currentPage = 0
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        slides = createSlides()
        addViewsToScrollView(slides)
        welcomePageControl.numberOfPages = slides.count
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        animation?.stopAnimation(true)
        DispatchQueue.main.async {
            for (_,view) in self.slides.enumerated() {
                
                if UIDevice.current.orientation.isLandscape {
                    view.buttonHeightConstraint?.constant = 30
                } else {
                    view.buttonHeightConstraint?.constant = 50
                }
                view.updateConstraints()
                view.subviews.forEach { $0.updateConstraints() }
            }
        }
    }
}

//MARK: - Configuration

extension OnboardingViewController {
    
    private func configureScrollView() {
        welcomeScrollView.translatesAutoresizingMaskIntoConstraints = false
        welcomeScrollView.isUserInteractionEnabled = true
        welcomeScrollView.contentInsetAdjustmentBehavior = .never
        welcomeScrollView.showsHorizontalScrollIndicator = false
        welcomeScrollView.delaysContentTouches = true
        welcomeScrollView.delegate = self
    }
    
    func createSlides() -> [OnboardingWelcomeView] {
    
        let view1 = OnboardingWelcomeView(x: 0,
                                          y: welcomeScrollView.frame.minY,
                                          width: welcomeScrollView.frame.width,
                                          height: welcomeScrollView.frame.height,
                                          mainLabelText: "Seja bem vindo!",
                                          descriptionLabelText: "Este é o melhor amigo da sua cabeleira: seja ela cacheada, lisa, ondulada ou crespa. E se você ainda estiver na dúvida sobre seu tipo de cabelo, a gente também te ajuda!")
        view1.button.isHidden = true
        let view2 = OnboardingWelcomeView(x: welcomeScrollView.frame.maxX,
                                          y: welcomeScrollView.frame.minY,
                                          width: welcomeScrollView.frame.width,
                                          height: welcomeScrollView.frame.height,
                                          mainLabelText: "Aqui você pode...",
                                          descriptionLabelText: "Conhecer mais sobre o seu cabelo e ainda descobrir a melhor forma de cuidar dele com as nossas recomendações. Vamos lá?")
        view2.button.addTarget(self, action: #selector(viewButtonTapped), for: .touchUpInside)
        view2.button.isUserInteractionEnabled = true
        return [view1,view2]
    }
    
    func addViewsToScrollView(_ views: [OnboardingWelcomeView]) {
        scrollContentPageSubview.translatesAutoresizingMaskIntoConstraints = false
        scrollContentPageSubview.backgroundColor = .white
        welcomeScrollView.addSubview(scrollContentPageSubview)
        addScrollContentPageSubviewConstraints()
        scrollContentPageSubview.layoutIfNeeded()
        
        for i in 0..<views.count {
            scrollContentPageSubview.addSubview(views[i])
            addScrollPagesConstraints(views, i)
        }
        addScrollPagesLeftConstraint(views)
    }
    
    func configureSkipButton() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(skipQuizz))
        skipButton.addGestureRecognizer(tap)
        skipButton.layer.borderColor = UIColor(red: 1, green: 0.754, blue: 0.7, alpha: 1).cgColor
        let label = skipButton.subviews.first as? UILabel
        label?.textColor = UIColor(red: 1, green: 0.918, blue: 0.9, alpha: 1)
    }
}

//MARK: - ScrollViewDelegate

extension OnboardingViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        welcomePageControl.currentPage = Int(pageIndex)
            
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        var pageIndex = floor(scrollView.contentOffset.x/view.frame.width)
        //needed for weird behaviour on orientation change - avoiding crash
        if pageIndex >= 2 || pageIndex < 0 {
            pageIndex = 1
        }
        animation = UIViewPropertyAnimator(duration: 1, dampingRatio: 0.4) {
            self.welcomeScrollView.setContentOffset(CGPoint(x: self.welcomeScrollView.subviews[Int(pageIndex)].frame.minX, y: 0), animated: false)
        }
        animation?.startAnimation()
    }
}

//MARK:- Touch Gestures

extension OnboardingViewController {
    @objc private func viewButtonTapped() {
        presenter.pushToQuizz()
    }
    
    @objc private func skipQuizz() {
        UserDefaults.standard.setValue(false, forKey: "quizz")
        QuizzPresenter.signup(answers: [:])
        presenter.coordinator?.showTabBar()
    }
}

//MARK: - Constraints

extension OnboardingViewController {
    
    private func addScrollContentPageSubviewConstraints() {
        scrollContentPageSubview
            .leadingAnchor
            .constraint(equalTo: welcomeScrollView.contentLayoutGuide.leadingAnchor)
            .isActive = true
        scrollContentPageSubview
            .trailingAnchor
            .constraint(equalTo: welcomeScrollView.contentLayoutGuide.trailingAnchor)
            .isActive = true
        scrollContentPageSubview
            .bottomAnchor
            .constraint(equalTo: welcomeScrollView.contentLayoutGuide.bottomAnchor)
            .isActive = true
        scrollContentPageSubview
            .topAnchor
            .constraint(equalTo: welcomeScrollView.contentLayoutGuide.topAnchor)
            .isActive = true
        scrollContentPageSubview
            .heightAnchor
            .constraint(equalTo: welcomeScrollView.heightAnchor)
            .isActive = true
        scrollContentPageSubview
            .widthAnchor
            .constraint(equalTo: welcomeScrollView.widthAnchor, multiplier: 2)
            .isActive = true
    }
    
    private func addScrollPagesConstraints(_ views: [OnboardingWelcomeView], _ i: Int) {
        views[i]
            .topAnchor
            .constraint(equalTo: scrollContentPageSubview.topAnchor)
            .isActive = true
        views[i]
            .bottomAnchor
            .constraint(equalTo: scrollContentPageSubview.bottomAnchor)
            .isActive = true
        views[i]
            .heightAnchor
            .constraint(equalTo: welcomeScrollView.heightAnchor)
            .isActive = true
        views[i]
            .widthAnchor
            .constraint(equalTo: welcomeScrollView.widthAnchor)
            .isActive = true
    }
    
    private func addScrollPagesLeftConstraint(_ views: [OnboardingWelcomeView]) {
        views[0]
            .leftAnchor
            .constraint(equalTo: scrollContentPageSubview.leftAnchor, constant: 0)
            .isActive = true
        views[1]
            .leftAnchor
            .constraint(equalTo: views[0].rightAnchor, constant: 0)
            .isActive = true
    }
}

extension OnboardingViewController: OnboardingPresenting {
}

