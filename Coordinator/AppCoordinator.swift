//
//  AppCoordinator.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 23/05/21.
//

import UIKit

extension UINavigationController {

  public func pushViewController(viewController: UIViewController,
                                 animated: Bool,
                                 completion: (() -> Void)?) {
    CATransaction.begin()
    CATransaction.setCompletionBlock(completion)
    pushViewController(viewController, animated: animated)
    CATransaction.commit()
  }
}

class AppCoordinator: Coordinator {
    
    //VCs
    
    public var tabBarCurrentVC: UIViewController?
    public var recommendationViewController: RecommendationViewController?
    public var quizzViewController: QuizzViewController?
    public var resultsViewController: ResultsViewController?
    public var navigationController: UINavigationController
    
    //Storyboard
    
    private var storyboard: UIStoryboard? = nil
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.navigationController.navigationBar.isHidden = true
    }
    
    func start() {
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        if (UserDefaults.standard.string(forKey: "id") != nil) {
            showTabBar()
            return
        }
        guard let onboardingVC = storyboard?.instantiateViewController(identifier: "OnboardingViewControllerID") as? OnboardingViewController else {
            return
        }
        onboardingVC.presenter.coordinator = self
        navigationController.pushViewController(onboardingVC, animated: true)
        
    }
    
    func showQuizz() {
        guard let quizzVC = storyboard?.instantiateViewController(identifier: "QuizzViewControllerID") as? QuizzViewController else {
            return
        }
        quizzViewController = quizzVC
        quizzVC.presenter.coordinator = self
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(viewController: quizzVC, animated: true, completion: nil)
    }
    
    func showTabBar() {
        guard let tabBarVC = storyboard?.instantiateViewController(identifier: "TabBarViewControllerID") as? TabBarViewController else {
            return
        }
        tabBarCurrentVC = tabBarVC
        tabBarVC.tabBarPresenter.coordinator = self
        navigationController.popViewController(animated: false)
        self.navigationController.pushViewController(viewController: tabBarVC, animated: false, completion: nil)
    }
    
    func instantiateTabBarVCS() -> [UIViewController] {
        guard let quizzVC = storyboard?.instantiateViewController(identifier: "QuizzViewControllerID") as? QuizzViewController else {
            return []
        }
        quizzVC.presenter.coordinator = self
        quizzVC.tabBarItem = UITabBarItem(title: "Quiz", image: UIImage(systemName: "questionmark.circle"), selectedImage: UIImage(systemName: "questionmark.circle.fill"))
        quizzViewController = quizzVC
        
        guard let recommmendationVC = storyboard?.instantiateViewController(identifier: "RecommendationViewControllerID") as? RecommendationViewController else {
            return []
        }
        
        guard let aboutVC = storyboard?.instantiateViewController(identifier: "AboutViewControllerID") else {
            return []
        }
        
        recommmendationVC.tabBarItem.image = UIImage(systemName: "house.fill")
        recommmendationVC.tabBarItem.title = "Início"
        aboutVC.tabBarItem = UITabBarItem(title: "Sobre", image: UIImage(systemName: "doc.text"), selectedImage: UIImage(systemName: "doc.text.fill"))
        recommmendationVC.recommendationPresenter.coordinator = self
        recommendationViewController = recommmendationVC
        
        guard let timelineVC = storyboard?.instantiateViewController(identifier: "TimelineViewControllerID") else {
            return []
        }
        timelineVC.tabBarItem = UITabBarItem(title: "Túnel do tempo", image: UIImage(systemName: "clock"), selectedImage: UIImage(systemName: "clock.fill"))
        
        return [recommmendationVC, quizzVC, timelineVC, aboutVC]
    }
    
    func instanstiateProductDescriptionModal() {
        guard let productVC = storyboard?.instantiateViewController(identifier: "ProductDetailsViewControllerID") as? ProductDetailsViewController else {
            return
        }
        productVC.recommendationPresenter = recommendationViewController?.recommendationPresenter
        navigationController.pushViewController(productVC, animated: true)
    }
    
    func instantiateResultsVC() {
        guard let resultsVC = storyboard?.instantiateViewController(identifier: "ResultsViewControllerID") as? ResultsViewController else {
            return
        }
        resultsVC.resultsPresenter.quizzPresenter = quizzViewController?.presenter
        resultsVC.resultsPresenter.coordinator = self
        resultsViewController = resultsVC
        navigationController.popViewController(animated: false)
        navigationController.pushViewController(viewController: resultsVC, animated: false, completion: nil)
    }
}
