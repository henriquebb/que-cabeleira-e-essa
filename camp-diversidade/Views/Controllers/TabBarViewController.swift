//
//  TabBarViewController.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 24/05/21.
//

import UIKit

protocol TabBarPresenting: AnyObject {
}

class TabBarViewController: UITabBarController {
    
    //IBOutlets
    
    @IBOutlet weak var tabBarView: UITabBar!
    
    //variables
    
    var tabBarPresenter = TabBarPresenter()
    
//MARK: - Lyfe Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        setTabBarControllerDelegate()
        tabBarPresenter.attachView(self)
        tabBarPresenter.setViewControllersToTabBarVC()
    }
    
    override func viewDidLayoutSubviews() {
        setTabBarItem()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addShadow()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { [self] _ in
            addShadow()
        }
    }
}

//MARK: TabBarPresenting

extension TabBarViewController: TabBarPresenting {
    
}

//MARK: - TabBarController Delegate

extension TabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabBarPresenter.setTabBarCurrentVC(vc: viewController)
    }
    
    func setTabBarControllerDelegate() {
        self.delegate = self
    }
}

//MARK: - UI

extension TabBarViewController {
    
    func setTabBarItem() {
        self.tabBarItem = UITabBarItem(title: "Início", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
    }
    
    func addShadow() {
        let shadowPath = UIBezierPath(roundedRect: tabBar.bounds, cornerRadius: 0)
        tabBar.layer.shadowPath = shadowPath.cgPath
        tabBar.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        tabBar.layer.shadowOpacity = 1
        tabBar.layer.shadowRadius = 18
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -5)
    }
}
