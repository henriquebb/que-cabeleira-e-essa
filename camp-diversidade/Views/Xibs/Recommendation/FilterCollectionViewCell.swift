//
//  FilterCollectionViewCell.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 26/05/21.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var filterName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.translatesAutoresizingMaskIntoConstraints = false
        filterName.translatesAutoresizingMaskIntoConstraints = false
    }
}

//MARK: - UI

extension FilterCollectionViewCell {
    func styleSelectedFilter() {
        self.layer.cornerRadius = 12
        self.backgroundColor = UIColor(red: 0.316, green: 0.305, blue: 0.871, alpha: 0.15)
        self.layer.borderWidth = 0
        filterName.textColor = UIColor(red: 0.316, green: 0.305, blue: 0.871, alpha: 1)
    }
    
    func styleUnselectedFilter() {
        self.layer.cornerRadius = 12
        self.backgroundColor = UIColor.clear
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1).cgColor
        filterName.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
    }
}
