//
//  RecommendationTableViewCell.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 24/05/21.
//

import UIKit

class RecommendationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var typeView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

//MARK: - UI Style

extension RecommendationTableViewCell {
    func styleCell() {
        typeView.layer.cornerRadius = 8
        self.cellBackgroundView?.layer.cornerRadius = 8
        self.clipsToBounds = false
        self.layer.masksToBounds = false
        //addShadow()
    }
    
    func addShadow() {
//
//        guard let backgroundView = cellBackgroundView else {
//            return
//        }
//        let rect = CGRect(x: self.bounds.minX, y: self.bounds.minY, width: self.bounds.width, height: self.bounds.height + 50)
//        let shadowPath = UIBezierPath(roundedRect: rect, cornerRadius: 8)
//        backgroundView.layer.shadowPath = shadowPath.cgPath
//        backgroundView.layer.shadowRadius = 28
//        backgroundView.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
//        backgroundView.layer.shadowOpacity = 1
//        backgroundView.layer.shadowOffset = CGSize(width: 4, height: 4)

        let shadows = UIView()
        shadows.frame = self.frame
        shadows.clipsToBounds = false
        self.addSubview(shadows)

        let shadowPath0 = UIBezierPath(roundedRect: shadows.bounds, cornerRadius: 8)
        let layer0 = CALayer()
        layer0.shadowPath = shadowPath0.cgPath
        layer0.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        layer0.shadowOpacity = 1
        layer0.shadowRadius = 28
        layer0.shadowOffset = CGSize(width: 4, height: 4)
        layer0.bounds = shadows.bounds
        layer0.position = shadows.center
        layer0.bounds = CGRect(x: 0, y: 0, width: shadows.frame.width, height: shadows.frame.height)
        shadows.layer.addSublayer(layer0)

        let shapes = UIView()
        shapes.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        shapes.clipsToBounds = true
        self.addSubview(shapes)
        //shapes.addSubview(productImage)
        //shapes.addSubview(titleLabel)
        //shapes.addSubview(descriptionLabel)
        //shapes.addSubview(typeView)
        
        shapes.translatesAutoresizingMaskIntoConstraints = false
        shapes.leftAnchor.constraint(equalTo: self.cellBackgroundView.leftAnchor, constant: 20).isActive = true
        shapes.rightAnchor.constraint(equalTo: self.cellBackgroundView.rightAnchor, constant: -20).isActive = true
        shapes.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        //productImage.heightAnchor.constraint(equalToConstant: 94).isActive = true
        //productImage.leftAnchor.constraint(equalTo: self, constant: 20)
        //productImage.
        
        shapes.updateConstraints()
        let layer1 = CALayer()
        layer1.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer1.bounds = shapes.bounds
        layer1.position = shapes.center
        shapes.layer.addSublayer(layer1)
        self.bringSubviewToFront(cellBackgroundView)
//        layer1.backgroundColor = UIColor.red.cgColor

        shapes.layer.cornerRadius = 8
    }
}
