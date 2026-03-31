import UIKit

final class ImageCacheServiceImpl: ImageCacheService {
    private let cache = NSCache<NSString, NSData>()
    
     init() {
        cache.countLimit = 100
        cache.totalCostLimit = 50 * 1024 * 1024
    }
    
    func getData(forKey key: String) -> Data? {
        return cache.object(forKey: key as NSString) as Data?
    }
    
    func setData(_ data: Data, forKey key: String) {
        cache.setObject(data as NSData, forKey: key as NSString)
    }
    
    func clear() {
        cache.removeAllObjects()
    }
}
