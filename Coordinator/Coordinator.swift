//
//  Coordinator.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 23/05/21.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}
