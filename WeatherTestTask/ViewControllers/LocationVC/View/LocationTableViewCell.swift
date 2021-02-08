

import UIKit
import SwiftSVG

class LocationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var weatherIcon: UIView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
        
    func configureCell(for weather: WeatherData) {
        
        cityNameLabel.text = weather.geoObject.locality?.name
        descriptionLabel.text = weather.fact.conditionString
        temperatureLabel.text = weather.fact.stringTemp + "°"

        guard let iconUrl = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(weather.fact.icon ?? "").svg") else { return }
        let weatherIcon = UIView(SVGURL: iconUrl) { svgLayer in
            svgLayer.resizeToFit(self.weatherIcon.bounds)
        }
        
        DispatchQueue.main.async {
            self.weatherIcon.addSubview(weatherIcon)
        }
    }
}
