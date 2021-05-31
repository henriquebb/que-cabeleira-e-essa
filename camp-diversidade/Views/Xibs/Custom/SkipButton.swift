//
//  SkipButton.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 24/05/21.
//

import UIKit

class SkipButton: UIView {
    
    let label = UILabel()
    
    override func awakeFromNib() {
        setup()
        addConstraintsToLabel()
    }
}

//MARK: - Setup

extension SkipButton {
    func setup() {
        self.backgroundColor = .clear
        self.layer.borderWidth = 3
        self.layer.cornerRadius = 19
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.text = "Pular"
        label.numberOfLines = 0
    }
}

//MARK: - Constraints

extension SkipButton {
    func addConstraintsToLabel() {
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
