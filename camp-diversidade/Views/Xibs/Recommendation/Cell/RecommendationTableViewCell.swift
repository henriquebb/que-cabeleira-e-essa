//
//  RecommendationTableViewCell.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 24/05/21.
//

import UIKit

class RecommendationTableViewCell: UITableViewCell {
    
    //IBOutlets
    
    @IBOutlet weak var stackViewContainer: UIStackView!
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var imageSuperview: UIView!
    @IBOutlet weak var imageStackView: UIStackView!
    
    //Variables
    
    var stackViewLeftConstraintWithoutImage: NSLayoutConstraint?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleCell()
        setupConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addShadow()
    }
    
    func setupCells(product: Product) {
        let url = URL(string: product.imagem)
        typeView.isHidden = false
        productImage.kf.setImage(with: url)
        titleLabel.text = product.nome
        descriptionLabel.text = product.descricao
        typeLabel.text = product.tipo
        selectionStyle = .none
        imageStackView.isHidden = false
        imageSuperview.backgroundColor = .white
        stackViewLeftConstraintWithoutImage?.isActive = false
        imageSuperview.updateConstraints()
        imageSuperview.layoutIfNeeded()
        self.layoutIfNeeded()
      
    }
    
    func setupTipsCells(tip: Tip) {
       
        imageStackView.isHidden = true
        stackViewLeftConstraintWithoutImage = stackViewContainer.leftAnchor.constraint(equalTo: cellBackgroundView.leftAnchor, constant: 20)
        stackViewLeftConstraintWithoutImage?.isActive = true
        
        titleLabel.text = tip.titulo
        descriptionLabel.text = tip.descricao
        typeView.isHidden = true
        productImage?.image = nil
        imageSuperview.backgroundColor = .clear
        self.layoutIfNeeded()
    }
}

//MARK: - UI Style

extension RecommendationTableViewCell {
    
    func setupConstraints() {
        stackViewLeftConstraintWithoutImage = stackViewContainer.leftAnchor.constraint(equalTo: cellBackgroundView.leftAnchor, constant: 20)
    }
    
    func styleCell() {
        typeView.layer.cornerRadius = 8
        imageSuperview.layer.cornerRadius = 8
        self.cellBackgroundView?.layer.cornerRadius = 8
        self.clipsToBounds = false
        self.contentView.clipsToBounds = false
        self.layer.masksToBounds = false
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
    }
    
    func addShadow() {
        let shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 28)
        cellBackgroundView.layer.shadowPath = shadowPath.cgPath
        cellBackgroundView.layer.shadowRadius = 28
        cellBackgroundView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        cellBackgroundView.layer.shadowOpacity = 1
    }
}
