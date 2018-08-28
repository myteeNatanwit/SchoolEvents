//
//  PickManyCell.swift
//  SchoolEvents
//
//  Created by Admin on 25/8/18.
//  Copyright © 2018 BobtheDeveloper. All rights reserved.
//

import UIKit

class PickManyCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var sub: UILabel!
    @IBOutlet weak var picked: UISwitch!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
