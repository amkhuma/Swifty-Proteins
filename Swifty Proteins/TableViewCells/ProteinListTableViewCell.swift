//
//  ProteinListTableViewCell.swift
//  Swifty Proteins
//
//  Created by Andile MKHUMA on 2018/10/25.
//  Copyright © 2018 Andile MKHUMA. All rights reserved.
//

import UIKit

class ProteinListTableViewCell: UITableViewCell {

    @IBOutlet weak var ligandName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
