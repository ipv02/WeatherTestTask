
import Foundation
import CoreLocation

class LocationManager {
    
    static let shared = LocationManager()
    
    private init() {}
    
    func fetchCoordinateCity(_ city: String, completion: @escaping (Result<CLLocationCoordinate2D, CLError>) -> Void) {
        CLGeocoder().geocodeAddressString(city) { (placemarks, error) in
            if let coordinates = placemarks?.first?.location?.coordinate {
                completion(.success(coordinates))
            } else if let error = error as? CLError {
                completion(.failure(error))
            }
        }
    }
}
