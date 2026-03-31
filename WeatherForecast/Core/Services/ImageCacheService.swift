import Foundation
import UIKit

protocol ImageCacheService {
    func getData(forKey key: String) -> Data?
    func setData(_ data: Data, forKey key: String)
    func clear()
}
