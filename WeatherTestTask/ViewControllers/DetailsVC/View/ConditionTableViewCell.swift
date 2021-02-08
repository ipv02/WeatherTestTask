
import UIKit

class ConditionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var seasonLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var conditionView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        conditionView.layer.cornerRadius = 10
        conditionView.addBottomShadow()
    }
}
