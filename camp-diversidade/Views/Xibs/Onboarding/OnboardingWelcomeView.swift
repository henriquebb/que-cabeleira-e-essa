//
//  OnboardingWelcomeView.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 22/05/21.
//

import UIKit

class OnboardingWelcomeView: UIView {
    
    //views
    
    let mainStackView = UIStackView()
    let descriptionStackView = UIStackView()
    var mainLabel = UILabel()
    var descriptionLabel = UILabel()
    var button = UIButton()
    
    //strings
    
    var mainLabelText: String = ""
    var descriptionLabelText: String = ""
    
    //constraints
    var buttonHeightConstraint: NSLayoutConstraint?

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(x: CGFloat,
         y: CGFloat,
         width: CGFloat,
         height: CGFloat,
         mainLabelText: String,
         descriptionLabelText: String) {

        super.init(frame: CGRect(x: x, y: y, width: width, height: height))
        self.translatesAutoresizingMaskIntoConstraints = false
        setup(mainLabelText, descriptionLabelText)
    }
}

//MARK: - Setup

extension OnboardingWelcomeView {
    
    private func setup(_ mainLabelText: String, _ descriptionLabelText: String) {
        setLabelTexts(mainLabelText, descriptionLabelText)
        configureSubviews()
        addSubviews()
        addLabelConstraints(labels: [mainLabel, descriptionLabel])
        addStackViewConstraints(stackViews: [mainStackView, descriptionStackView])
        addButtonConstraints()
    }
}

//MARK: - Configuration

extension OnboardingWelcomeView {
    
    private func addSubviews() {
        mainStackView.addArrangedSubview(mainLabel)
        descriptionStackView.addArrangedSubview(descriptionLabel)
        self.addSubview(button)
        self.addSubview(mainStackView)
        self.addSubview(descriptionStackView)
    }
    
    private func setLabelTexts(_ mainLabelText: String, _ descriptionLabelText: String) {
        self.mainLabelText = mainLabelText
        self.descriptionLabelText = descriptionLabelText
    }
    
    private func configureSubviews() {
        configureButton()
        configureLabels(labels: [mainLabel, descriptionLabel])
        configureStackViews(stackViews: [mainStackView, descriptionStackView])
    }
    
    private func configureButton() {
        styleButton()
        button.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureLabels(labels: [UILabel]) {
        mainLabel.text = mainLabelText
        descriptionLabel.text = descriptionLabelText
        labels.forEach { (label) in
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
        }
        styleMainLabel()
        styleDescriptionLabel()
    }
    
    private func configureStackViews(stackViews: [UIStackView]) {
        stackViews.forEach { (stackView) in
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}


//MARK: - UI

extension OnboardingWelcomeView {
    
    private func styleButton() {
        button.backgroundColor = UIColor(red: 0.316, green: 0.305, blue: 0.871, alpha: 1)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.tintColor = .white
        button.setTitle("Começar", for: .normal)
        button.layer.cornerRadius = 8
    }
    
    private func styleMainLabel() {
        mainLabel.textColor = UIColor(red: 0.011, green: 0, blue: 0.512, alpha: 1)
        mainLabel.font = UIFont.systemFont(ofSize: 28)
        if mainLabel.traitCollection.horizontalSizeClass == .regular && mainLabel.traitCollection.verticalSizeClass == .regular {
            mainLabel.font = UIFont.systemFont(ofSize: 56, weight: .bold)
        } else if mainLabel.traitCollection.horizontalSizeClass == .compact {
            mainLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        }
    }
    
    private func styleDescriptionLabel() {
        descriptionLabel.textColor = UIColor(red: 0.133, green: 0.133, blue: 0.133, alpha: 1)
        descriptionLabel.font = UIFont.systemFont(ofSize: 17)
        if descriptionLabel.traitCollection.horizontalSizeClass == .regular && descriptionLabel.traitCollection.verticalSizeClass == .regular {
            descriptionLabel.font = UIFont.systemFont(ofSize: 26)
        } else if descriptionLabel.traitCollection.horizontalSizeClass == .compact {
            descriptionLabel.font = UIFont.systemFont(ofSize: 17)
        }
    }
}

//MARK: - Constraints

extension OnboardingWelcomeView {
    
    private func addLabelConstraints(labels: [UILabel]) {
        labels.forEach { (label) in
            guard let superview = label.superview else {
                return
            }
            label.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 0).isActive = true
            label.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: 0).isActive = true
        }
    }
    
    private func addButtonConstraints() {
        guard let superview = button.superview else {
            return
        }
        button.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: 20).isActive = true
        button.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -20).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -28).isActive = true
        if button.traitCollection.verticalSizeClass == .compact {
            buttonHeightConstraint = button.heightAnchor.constraint(equalToConstant: 30)
        } else {
            buttonHeightConstraint = button.heightAnchor.constraint(equalToConstant: 50)
        }
        buttonHeightConstraint?.isActive = true
    }
    
    private func addStackViewConstraints(stackViews: [UIStackView]) {
        
        stackViews.forEach { (stackView) in
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        }
        addMainStackViewConstraints()
        addDescriptionStackViewConstraints()
    }
    
    private func addMainStackViewConstraints() {
        mainStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 24).isActive = true
        mainStackView.layoutIfNeeded()
    }
    
    private func addDescriptionStackViewConstraints() {
        descriptionStackView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 16).isActive = true
    }
}
