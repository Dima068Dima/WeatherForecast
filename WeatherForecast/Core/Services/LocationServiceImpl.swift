import CoreLocation

final class LocationServiceImpl: NSObject {
    private let locationManager = CLLocationManager()
    private var continuation: CheckedContinuation<(lat: Double, lon: Double), Error>?
    private let defaultLocation: (lat: Double, lon: Double) = (
        Constants.defaultLatitude,
        Constants.defaultLongitude
    )
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }
}

// MARK: - LocationService -
extension LocationServiceImpl: LocationService {
    func requestLocation() async throws -> (lat: Double, lon: Double) {
        return try await withCheckedThrowingContinuation { continuation in
            self.continuation = continuation
            
            let status = locationManager.authorizationStatus
            
            switch status {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .authorizedWhenInUse, .authorizedAlways:
                locationManager.requestLocation()
            case .denied, .restricted:
                continuation.resume(returning: defaultLocation)
            @unknown default:
                continuation.resume(returning: defaultLocation)
            }
        }
    }
}

// MARK: - CLLocationManagerDelegate
extension LocationServiceImpl: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        case .denied, .restricted:
            continuation?.resume(returning: defaultLocation)
            continuation = nil
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            continuation?.resume(returning: defaultLocation)
            continuation = nil
            return
        }
        
        continuation?.resume(returning: (location.coordinate.latitude, location.coordinate.longitude))
        continuation = nil
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        continuation?.resume(returning: defaultLocation)
        continuation = nil
    }
}
