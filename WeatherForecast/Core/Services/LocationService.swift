import Foundation

protocol LocationService {
    func requestLocation() async throws -> (lat: Double, lon: Double)
}
