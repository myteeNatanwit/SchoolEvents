

import UIKit

class TableCell: UITableViewCell {

    @IBOutlet var nameLbl: UILabel!
    @IBOutlet weak var xy: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
