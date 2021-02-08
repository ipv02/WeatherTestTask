

import UIKit

class LocationTableViewController: UITableViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: - Private properties
    private var weatherData: WeatherData!
    private var locations: [WeatherData] = []
    
    //MARK: - Life cicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        
        fetchCities()
        
        searchBar.delegate = self
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        locations.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "location", for: indexPath) as! LocationTableViewCell
        let weather = locations[indexPath.row]
        cell.configureCell(for: weather)
        return cell
    }
    
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cityWeather = locations[indexPath.row]
        performSegue(withIdentifier: "detailsSegue", sender: cityWeather)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        locations.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    private func fetchCities() {
        for city in DataManager.shared.cities {
            NetworkManager.shared.fetchWeatherData(latitude: city.latitude, longitude: city.longitude) { weatherData in
                DispatchQueue.main.async {
                    self.weatherData = weatherData
                    self.locations.append(weatherData!)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsSegue" {
            let detailsVC = segue.destination as! DetailsViewController
            detailsVC.cityWeather = sender as? WeatherData
        }
    }
}

// MARK: - SearchBar Delegate
extension LocationTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        if let city = searchBar.text?.capitalized, !city.isEmpty {
            LocationManager.shared.fetchCoordinateCity(city) { result in
                switch result {
                case .success(let coordinate):
                    NetworkManager.shared.fetchWeatherData(latitude: coordinate.latitude, longitude: coordinate.longitude) { weatherData in
                        DispatchQueue.main.async {
                            self.weatherData = weatherData
                            self.locations.insert(weatherData!, at: 0)
                            self.tableView.reloadData()
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        searchBar.searchTextField.text = nil
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        searchBar.setImage(UIImage(), for: .clear, state: .normal)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
        searchBar.showsCancelButton = false
    }
}


