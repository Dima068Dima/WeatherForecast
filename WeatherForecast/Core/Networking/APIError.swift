import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case noData
    case decodingError
    case networkError(Error)
    case invalidResponse
    case unauthorized
    case notFound
    
    var errorDescription: String? {
        switch self {
            case .invalidURL:
                return Strings.Errors.invalidURL
            case .noData:
                return Strings.Errors.noData
            case .decodingError:
                return Strings.Errors.decodingError
            case .networkError(let error):
                return "\(Strings.Errors.network) \(error.localizedDescription)"
            case .invalidResponse:
                return Strings.Errors.invalidResponse
            case .unauthorized:
                return Strings.Errors.unauthorized
            case .notFound:
                return Strings.Errors.notFound
        }
    }
}
