
import UIKit


public struct Images: Decodable {
    
    public let urls: [URL]
    
    enum CodingKeys: String, CodingKey {
            case urls = "images"
    }
}


