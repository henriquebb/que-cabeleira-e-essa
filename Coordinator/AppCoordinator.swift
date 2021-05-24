//
//  AppCoordinator.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 23/05/21.
//

import UIKit

class AppCoordinator: Coordinator {
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
        navigationController.pushViewController(quizzVC, animated: true)
    }
    
    func showTabBar() {
        guard let tabBarVC = storyboard?.instantiateViewController(identifier: "TabBarViewControllerID") as? TabBarViewController else {
            return
        }
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(tabBarVC, animated: true)
    }
}
