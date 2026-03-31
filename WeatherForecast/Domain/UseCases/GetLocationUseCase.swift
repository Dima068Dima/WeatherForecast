import Foundation

protocol GetLocationUseCase {
    func execute() async throws -> (lat: Double, lon: Double)
}
