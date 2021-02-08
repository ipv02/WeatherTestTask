

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Properties
    var cityWeather: WeatherData!
    
    //MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.title = cityWeather.geoObject.locality?.name
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}


extension DetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return 1
        default: return cityWeather.forecasts?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        configureCell(indexPath)
    }
    
    // MARK: - Table view delegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return view.bounds.height / 2.5
        case 1: return 100
        default: return 80
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Configure cell
    private func configureCell(_ indexPath: IndexPath) -> UITableViewCell {
        
        // Current weather
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "currentCell", for: indexPath) as! CurrentTableViewCell
            cell.cityNameLabel.text = cityWeather.geoObject.locality?.name
            cell.currentTempLabel.text = cityWeather.fact.stringTemp + "°"
            
            guard let iconUrl = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(cityWeather.fact.icon ?? "").svg") else { return cell }
            let weatherIcon = UIView(SVGURL: iconUrl) { svgLayer in
                svgLayer.resizeToFit(cell.weatherIcon.bounds)
            }
            
            DispatchQueue.main.async {
                cell.weatherIcon.addSubview(weatherIcon)
            }
            
            cell.descriptionLabel.text = cityWeather.fact.conditionString
            cell.feelsLikeLabel.text = "ощущается:" + " " + cityWeather.fact.feelsLikeString + "°"
            cell.separatorInset = .init(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            
            return cell
        }
        
        // Condition weather
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "conditionCell", for: indexPath) as! ConditionTableViewCell
            cell.seasonLabel.text = cityWeather.fact.seasonString
            cell.windSpeedLabel.text = cityWeather.fact.windSpeedString + "м/с"
            cell.humidityLabel.text = cityWeather.fact.humidityString + "%"
            cell.pressureLabel.text = cityWeather.fact.pressureMmString + "мм"
            cell.separatorInset = .init(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            
            cell.backgroundColor = .white
            
            return cell
        }
        
        // Forecast for 7 day's
        let cell = tableView.dequeueReusableCell(withIdentifier: "forecastCell", for: indexPath) as! ForecastTableViewCell
        let date = unixConvertor(unixTime: cityWeather.forecasts?[indexPath.row].dateTs ?? 0.0, type: .date)
        cell.dateLabel.text = date
        cell.tempLabel.text = "\(cityWeather.forecasts?[indexPath.row].parts?.day?.tempAvgString ?? "")°"
        
        guard let iconUrl = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(cityWeather.forecasts?[indexPath.row].parts?.day?.icon ?? "").svg") else { return cell }
        let weatherIcon = UIView(SVGURL: iconUrl) { svgLayer in
            svgLayer.resizeToFit(cell.weatherIcon.bounds)
        }
        
        DispatchQueue.main.async {
            cell.weatherIcon.addSubview(weatherIcon)
        }
        
        return cell
    }
}
