import UIKit

class LevelCell: UITableViewCell {

    @IBOutlet weak var selectImageView: UIImageView!
    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var imageLvlView: UIImageView!
    @IBOutlet weak var backgroundCell: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundCell.layer.cornerRadius = 20
    }


}
