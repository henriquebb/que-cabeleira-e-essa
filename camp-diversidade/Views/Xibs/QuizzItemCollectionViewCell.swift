//
//  QuizzItemCollectionViewCell.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 19/05/21.
//

import UIKit

class QuizzItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var quizzItemCollectionViewCellView: UIView!
    @IBOutlet weak var quizzItemCollectionViewCellBottomView: UIView!
    @IBOutlet weak var quizzAnswer: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureQuizzItemCollectionViewCellView()
        configureQuizzItemCollectionViewCellBottomView()
    }

}

// MARK: - Quizz Cell UI

extension QuizzItemCollectionViewCell {
    func configureQuizzItemCollectionViewCellView() {
        quizzItemCollectionViewCellView.layer.cornerRadius = 8
        let shadowPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 109, height: 119), cornerRadius: 8)
        self.layer.shadowPath = shadowPath.cgPath
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 28
        self.layer.shadowOffset = .zero
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        
    }
    
    func configureQuizzItemCollectionViewCellBottomView() {
        quizzItemCollectionViewCellBottomView.layer.cornerRadius = 8
        quizzItemCollectionViewCellBottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
}
