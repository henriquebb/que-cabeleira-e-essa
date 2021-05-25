//
//  ButtonViewShadow.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 25/05/21.
//

import UIKit

class ButtonViewShadow {
    public static func configureButtonViewShadow(button: UIView) {
        
        button.clipsToBounds = false
        button.layer.masksToBounds = false

        let shadowPath0 = UIBezierPath(roundedRect: CGRect(
                                        x: button.bounds.minX,
                                        y: button.bounds.minY,
                                        width: button.bounds.width,
                                        height: button.bounds.height/2),
                                       cornerRadius: 0)
        button.layer.shadowPath = shadowPath0.cgPath
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.08).cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowRadius = 18
        button.layer.shadowOffset = CGSize(width: 0, height: -5)
        //submitButtonView.layer.bounds = submitButtonView.bounds
        //submitButtonView.layer.position = submitButtonView.center
        button.superview?.bringSubviewToFront(button)
    }
}
