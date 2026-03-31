import Foundation

protocol ImageLoadable {
    var iconURL: String { get }
    var imageData: Data? { get set }
}
