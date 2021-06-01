//
//  DeveloperTableViewCell.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 26/05/21.
//

import UIKit

class DeveloperTableViewCell: UITableViewCell {

    @IBOutlet weak var developerName: UILabel!
    @IBOutlet weak var developerImage: UIImageView!
    @IBOutlet weak var developerPosition: UILabel!
    @IBOutlet weak var developerDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(developers: [Developer], index: Int) {
        developerName.text = developers[index].title
        developerPosition.text = developers[index].position
        developerDescription.text = developers[index].description
        developerImage.image = developers[index].image
    }
}
