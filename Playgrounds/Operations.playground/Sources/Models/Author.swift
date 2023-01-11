import Foundation

public struct Author: Identifiable, Decodable {
    
    public let id: Int
    public let name: String
    public let avatar_urls: AvatarUrl
    
    
    public struct AvatarUrl: Decodable {
        
        public let _24: URL
        public let _48: URL
        public let _96: URL
        
        enum CodingKeys: String, CodingKey {
            case _24 = "24"
            case _48 = "48"
            case _96 = "96"
        }
    }
}
