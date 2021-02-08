
import UIKit

class CurrentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var weatherIcon: UIView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var currentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        currentView.layer.cornerRadius = 10
        currentView.addBottomShadow()
    }
}
