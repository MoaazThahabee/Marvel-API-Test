//
//  CharacterListTableViewCell.swift
//  Marvel Api Test
//
//  Created by Moaaz Al-Thahabee on 12/20/18.
//  Copyright © 2018 Moaaz Al-Thahabee. All rights reserved.
//

import UIKit

class CharactersListTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
