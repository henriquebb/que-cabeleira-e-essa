//
//  Filter.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 26/05/21.
//

import UIKit

class Filter {
    
    init() {
        //load
    }
    
    static func configureSelectedCategoryButton(_ label: UILabel?) {
        label?.textColor = UIColor.init(red: 0.015, green: 0, blue: 0.75, alpha: 1)
        label?.font = UIFont.systemFont(ofSize: label?.font.pointSize ?? 0, weight: .medium)
        label?.layoutIfNeeded()
    }
    
    static func configureDeselectedCategoryButton(_ label: UILabel?) {
        label?.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)
        label?.font = UIFont.systemFont(ofSize: label?.font.pointSize ?? 0, weight: .regular)
    }
}
