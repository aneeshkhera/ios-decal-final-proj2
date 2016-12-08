

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var cellButton: UIButton!
    
    @IBOutlet weak var restoreButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
