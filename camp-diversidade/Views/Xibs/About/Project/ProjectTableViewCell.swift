//
//  ProjectTableViewCell.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 26/05/21.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {

    @IBOutlet weak var projectImageSuperview: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.projectImageSuperview.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
