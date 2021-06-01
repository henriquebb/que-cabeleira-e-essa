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
    var titleLeftConstraintWithoutImage: NSLayoutConstraint?
    var descriptionLeftConstraintWithoutImage: NSLayoutConstraint?
    var imageSuperViewConstraints: [NSLayoutConstraint]?
    
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
        //self.layoutIfNeeded()
        addShadow()
    }
    
    func setupCells(product: Product) {
        //productImage.insertSubview(self, at: 0)
        let url = URL(string: product.imagem)
        typeView.isHidden = false
        productImage.kf.setImage(with: url)
        titleLabel.text = product.nome
        descriptionLabel.text = product.descricao
        typeLabel.text = product.tipo
        selectionStyle = .none
        //typeView.isHidden = false
        //imageStackView.isHidden = false
        imageStackView.isHidden = false
        imageSuperview.backgroundColor = .white
        stackViewLeftConstraintWithoutImage?.isActive = false
        //self.bringSubviewToFront(imageSuperview)
        //self.addSubview(imageSuperview)
        //NSLayoutConstraint.activate(imageSuperview.constraints)
        imageSuperview.updateConstraints()
        imageSuperview.layoutIfNeeded()
        self.layoutIfNeeded()
      
    }
    
    func setupTipsCells(tip: Tip) {
       
//        imageSuperview.constraints.forEach { constraint in
//            constraint.isActive = false
//        }
        //imageSuperview.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        //imageSuperview.removeFromSuperview()
        //self.sendSubviewToBack(imageSuperview)
//        NSLayoutConstraint.deactivate(imageSuperview.constraints)
////        imageSuperview.constraints.forEach { constraint in
////            imageSuperViewConstraints?.append(constraint)
////            constraint.isActive = false
////        }
//        self.imageSuperview.isHidden = true
//        self.imageSuperview.layoutIfNeeded()
        
        imageStackView.isHidden = true
//        imageSuperview.isHidden = true
//        productImage?.isHidden = true
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
