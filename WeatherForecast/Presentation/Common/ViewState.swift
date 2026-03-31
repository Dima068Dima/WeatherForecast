import Foundation

enum ViewState<T: Equatable>: Equatable {
    case loading
    case success(T)
    case error(String)
    
    static func == (lhs: ViewState<T>, rhs: ViewState<T>) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case (.error(let lhsError), .error(let rhsError)):
            return lhsError == rhsError
        case (.success(let lhsData), .success(let rhsData)):
            return lhsData == rhsData
        default:
            return false
        }
    }
}
