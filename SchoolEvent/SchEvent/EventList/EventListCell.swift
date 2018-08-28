//
//  EventListCell.swift
//  SchoolEvents
//
//  Created by Admin on 26/8/18.
//  Copyright © 2018 BobtheDeveloper. All rights reserved.
//

import UIKit

class EventListCell: UITableViewCell {
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var loc: UILabel!
    @IBOutlet weak var organiser: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var fee: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var category: UILabel!
    
    @IBOutlet weak var distance: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
