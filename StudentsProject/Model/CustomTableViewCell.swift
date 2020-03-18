//
//  CustomTableViewCell.swift
//  StudentsProject
//
//  Created by Egor on 18.03.2020.
//  Copyright © 2020 Egor. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    func awakeFromNib(name: String, surname: String, rate: Int) {
        super.awakeFromNib()
        
        self.nameLabel.text = name
        self.surnameLabel.text = surname
        self.rateLabel.text = "rate: \(rate)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
