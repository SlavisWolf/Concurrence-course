import UIKit


open class NetworkOperation: AsyncOperation {

    private var url: URL?
    
    public var dataOutput: Data?
    public var imageOutput: UIImage? {
        
        if let dataOutput {
            return UIImage(data: dataOutput)
        }
        return nil
    }
    
    public init(url: URL? = nil) {
        self.url = url
        super.init()
    }
    
    open override func main() {
        
        if let dependency = dependencies.first as? NetworkOperation, let data = dependency.dataOutput {
            
            let decoder = JSONDecoder()
            if let postJSON = try? decoder.decode([Post].self, from: data) {
                
                guard let article = postJSON.first, let hrefAuthor = article._links.author.first?.href else {
                    state = .Finished
                    return
                }
                
                url = hrefAuthor
                
            } else if let authorJSON = try? decoder.decode(Author.self, from: data) {
                url = authorJSON.avatar_urls._96
            } else {
                print("Decoding error...")
                url = nil
                state = .Finished
            }
            
            network { data in
                self.dataOutput = data
                self.state = .Finished
            }
            
        } else {
            network { data in
                self.dataOutput = data
                self.state = .Finished
            }
        }
    }
    
    private func network(callback: @escaping (Data) -> ()) {
        guard let url else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data, let response = response as? HTTPURLResponse, error == nil else {
                if let error {
                    print("Error: \(error)")
                }
                self.state = .Finished
                return
            }
            
            guard response.statusCode == 200 else {
                print("Error with code: \(response.statusCode)")
                self.state = .Finished
                return
            }
        
            callback(data)
        }.resume()
    }
}

