import Foundation
import UIKit

// The array has images of insects, if you have arachnophobia don't open some links, remove the last two.
public let urlImages =
[
    "https://www.purina.co.uk/sites/default/files/2020-11/Working%20Dogs%20Everything%20You%20Need%20to%20KnowTEASER.jpeg",
    "https://dynaimage.cdn.cnn.com/cnn/c_fill,g_auto,w_1200,h_675,ar_16:9/https%3A%2F%2Fcdn.cnn.com%2Fcnnnext%2Fdam%2Fassets%2F220818142713-dogs-tears-emotions-wellness-stock.jpg",
    "https://i.natgeofe.com/n/d742b985-727d-4f14-85ff-5294fc44ef5e/snakes_02_16x9.jpg",
    "https://upload.wikimedia.org/wikipedia/commons/4/4d/12_-_The_Mystical_King_Cobra_and_Coffee_Forests.jpg",
    "https://www.vets4pets.com/siteassets/species/cat/kitten/istock-1170736928-1.jpg?width=1040",
    "https://i.natgeofe.com/n/9135ca87-0115-4a22-8caf-d1bdef97a814/75552.jpg",
    "https://i.natgeofe.com/n/76aea853-00cf-41f4-a618-3a1b0ff2afb4/spiders_07_3x4.jpg",
    "https://felipedelbosque.files.wordpress.com/2011/10/fdb8679.jpg"]

public func downloadImage (url:URL, completion: @escaping (UIImage?) -> Void) {
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        
        guard let data, let response = response as? HTTPURLResponse, error == nil else {
            
            if let error {
                print("Error in the operation: \(error)")
            }
            completion(nil)
            return
        }
        
        if response.statusCode == 200 {
            
            if let image = UIImage(data: data) {
                completion(image)
            } else {
                print( "It isn't an image")
                completion(nil)
            }
        } else {
            print("Error: \(response.statusCode)")
            completion(nil)
        }
    }.resume()
}
