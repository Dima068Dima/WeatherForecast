import Foundation
import Alamofire

final class NetworkManagerImpl {
    private let session: Session
    private let baseURL: String
    private let timeoutInterval: TimeInterval
    
    init() {
        self.baseURL = Constants.API.baseURL
        self.timeoutInterval = Constants.API.timeoutInterval
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = timeoutInterval
        configuration.timeoutIntervalForResource = timeoutInterval
        self.session = Session(configuration: configuration)
    }
        
    private func mapError(_ error: AFError) -> APIError {
        if error.isResponseValidationError {
            return .invalidResponse
        } else if error.isSessionTaskError {
            return .networkError(error)
        } else {
            return .decodingError
        }
    }
}

// MARK: - NetworkManager -
extension NetworkManagerImpl: NetworkManager {
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod = .get,
        parameters: [String: Any]? = nil
    ) async throws -> T {
        let url = baseURL + endpoint
        
        return try await withCheckedThrowingContinuation { continuation in
            session.request(url, method: method, parameters: parameters)
                .validate(statusCode: 200..<300)
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                        case .success(let data):
                            continuation.resume(returning: data)
                        case .failure(let error):
                            let apiError = self.mapError(error)
                            continuation.resume(throwing: apiError)
                    }
                }
        }
    }
}
