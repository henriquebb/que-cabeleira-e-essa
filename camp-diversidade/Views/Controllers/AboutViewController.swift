//
//  AboutViewController.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 26/05/21.
//

import UIKit

class AboutViewController: UIViewController {
    
    //IBOutlets

    @IBOutlet weak var aboutStackView: UIStackView!
    @IBOutlet weak var aboutTableView: UITableView! {
        didSet {
            aboutTableView.delegate =  self
            aboutTableView.dataSource = self
            aboutTableView.allowsSelection = false
            aboutTableView.separatorStyle = .none
        }
    }
    
    //Variables
    
    var lastIndexSelected: Int = -1
    var developers: [Developer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }
}

//MARK: - Setup

extension AboutViewController {
    private func setup() {
        lastIndexSelected = 0
        Filter.configureSelectedCategoryButton(aboutStackView.subviews.first as? UILabel)
        setupDevelopers()
        configureStackViewTouch()
        registerProjectTableViewCell()
        registerDeveloperTableViewCell()
    }
}

//MARK: TableView

extension AboutViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lastIndexSelected == AboutCategories.projeto.rawValue ? 1 : developers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if lastIndexSelected == AboutCategories.projeto.rawValue {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectTableViewCell") as? ProjectTableViewCell
            else { return ProjectTableViewCell() }
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DeveloperTableViewCell") as? DeveloperTableViewCell
        else { return DeveloperTableViewCell() }
        cell.setupCell(developers: developers, index: indexPath.item)
        return cell
    }
}

//MARK: - TableView Services

extension AboutViewController {
    func setupDevelopers() {
        let developerLibrary = DeveloperLibrary()
        developerLibrary.addDevelopers()
        developers = developerLibrary.developers
    }
    
    private func registerProjectTableViewCell() {
        let nib = UINib(nibName: "ProjectTableViewCell", bundle: Bundle(for: ProjectTableViewCell.self))
        aboutTableView.register(nib, forCellReuseIdentifier: "ProjectTableViewCell")
    }
    
    private func registerDeveloperTableViewCell() {
        let nib = UINib(nibName: "DeveloperTableViewCell", bundle: Bundle(for: DeveloperTableViewCell.self))
        aboutTableView.register(nib, forCellReuseIdentifier: "DeveloperTableViewCell")
    }
}

//MARK: - Touch

extension AboutViewController {
    private func configureStackViewTouch() {
        let touch = UITapGestureRecognizer(target: self, action: #selector(handleTouch(_:)))
        aboutStackView.addGestureRecognizer(touch)
    }
    
    @objc private func handleTouch(_ sender: UITapGestureRecognizer) {
        for (index,view) in aboutStackView.subviews.enumerated() {
            let location = sender.location(in: view)
            if (view.hitTest(location, with: nil)) != nil {
                let lastLabel = aboutStackView.subviews[lastIndexSelected] as? UILabel
                Filter.configureDeselectedCategoryButton(lastLabel)
                Filter.configureSelectedCategoryButton(view as? UILabel)
                lastIndexSelected = index
                aboutTableView.reloadData()
            }
        }
    }
}
