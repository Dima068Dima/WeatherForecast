import Foundation
import Alamofire

protocol NetworkManager {
    func request<T: Decodable>(
        endpoint: String,
        method: HTTPMethod,
        parameters: [String: Any]?
    ) async throws -> T
}
