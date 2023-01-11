import Foundation


public struct Post: Identifiable, Decodable {
    
    public let id: Int
    public let title: Rendered
    public let content: Rendered
    public let excerpt: Rendered
    public let _links: Links
    
    
   public struct Rendered: Decodable {
       public let rendered: String
    }
    
    public struct Author: Decodable {
        public let href: URL
    }
    
    public struct Links: Decodable {
        public let author: [Post.Author]
    }
}
