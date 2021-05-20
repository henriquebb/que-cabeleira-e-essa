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
    }
    
    func configureQuizzItemCollectionViewCellBottomView() {
        quizzItemCollectionViewCellBottomView.layer.cornerRadius = 8
        quizzItemCollectionViewCellBottomView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
}
