
import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private init() {}
    
    var cities = [
        City(latitude: 45.023877, longitude: 38.970157),
        City(latitude: 55.755773, longitude: 37.617761),
        City(latitude: 44.723489, longitude: 37.76866),
        City(latitude: 59.938806, longitude: 30.314278),
        City(latitude: 43.581509, longitude: 39.722882),
        City(latitude: 54.734768, longitude: 55.957838 ),
        City(latitude: 48.472584, longitude: 135.057732),
        City(latitude: 55.159774, longitude: 61.402455),
        City(latitude: 56.495116, longitude: 84.972128),
        City(latitude: 53.195533, longitude: 50.101801)
    ]
}
