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
    var tabBarCurrentVC: UIViewController?
    var navigationController: UINavigationController
    private var storyboard: UIStoryboard? = nil
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let onboardingVC = storyboard?.instantiateViewController(identifier: "OnboardingViewControllerID") as? OnboardingViewController else {
            return
        }
        onboardingVC.presenter.coordinator = self
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(onboardingVC, animated: true)
        
    }
    
    func showQuizz() {
        guard let quizzVC = storyboard?.instantiateViewController(identifier: "QuizzViewControllerID") as? QuizzViewController else {
            return
        }
        quizzVC.presenter.coordinator = self
        navigationController.navigationBar.isHidden = true
        navigationController.popViewController(animated: false)
        //navigationController.modalPresentationStyle = .overCurrentContext
        //navigationController.present(quizzVC, animated: true, completion: nil)
        navigationController.pushViewController(viewController: quizzVC, animated: true, completion: nil)
    }
    
    func showTabBar() {
        guard let tabBarVC = storyboard?.instantiateViewController(identifier: "TabBarViewControllerID") as? TabBarViewController else {
            return
        }
        tabBarVC.tabBarPresenter.coordinator = self
        navigationController.popViewController(animated: false)
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(viewController: tabBarVC, animated: true) {
            tabBarVC.selectedIndex = 0
        }
    }
    
    func instantiateTabBarVCS() -> [UIViewController] {
        guard let quizzVC = storyboard?.instantiateViewController(identifier: "QuizzViewControllerID") as? QuizzViewController else {
            return []
        }
        //quizzVC.tabBarItem.selectedImage = UIImage(systemName: "questionmark.circle.fill")
        quizzVC.tabBarItem = UITabBarItem(title: "Quizz", image: UIImage(systemName: "questionmark.circle"), selectedImage: UIImage(systemName: "questionmark.circle.fill"))
        
        guard let recommmendationVC = storyboard?.instantiateViewController(identifier: "RecommendationViewControllerID") as? RecommendationViewController else {
            return []
        }
        recommmendationVC.tabBarItem.image = UIImage(systemName: "house.fill")
        recommmendationVC.recommendationPresenter.coordinator = self
        return [recommmendationVC, quizzVC]
    }
    
    func instanstiateProductDescriptionModal() {
        guard let productVC = storyboard?.instantiateViewController(identifier: "ProductDetailsViewControllerID") as? ProductDetailsViewController else {
            return
        }
        navigationController.pushViewController(productVC, animated: true)
        //navigationController.present(productVC, animated: true, completion: nil)
    }
}
