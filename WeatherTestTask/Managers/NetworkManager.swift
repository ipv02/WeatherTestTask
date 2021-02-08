
import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchWeatherData(latitude: Double, longitude: Double, completion: @escaping (WeatherData?) -> Void) {
        
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(latitude)&lon=\(longitude)"
        guard let url = URL(string: urlString) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("d56e2c3b-b4ca-4c63-90c3-7ca0863803b5", forHTTPHeaderField: "X-Yandex-API-Key")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error { print(error); return }
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let weatherData = try decoder.decode(WeatherData.self, from: data)
                completion(weatherData)
            } catch let error {
                print(error)
            }
        }.resume()
    }
}
