//
//  RetailTableViewCell.swift
//  JSONParser
//
//  Created by Wyatt on 9/27/16.
//  Copyright © 2016 Wyatt. All rights reserved.
//

import UIKit

class RetailTableViewCell: UITableViewCell {

    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
