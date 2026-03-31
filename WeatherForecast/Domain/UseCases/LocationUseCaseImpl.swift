import Foundation
import CoreLocation

final class LocationUseCaseImpl {
    
    private let locationService: LocationService
    
    init(locationService: LocationService) {
        self.locationService = locationService
    }
}

// MARK: - GetLocationUseCase -
extension LocationUseCaseImpl: GetLocationUseCase {
    func execute() async throws -> (lat: Double, lon: Double) {
        return try await locationService.requestLocation()
    }
}
