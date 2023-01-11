

import UIKit

var result = [UIImage]()
//To not overload the network interface we'll use a serial queue, it's slower, but it's safer

DispatchQueue(label: "com.ajibanez.serial").async {
    
    let downloadGroup = DispatchGroup()
    
    urlImages.forEach { urlString in
        guard let url = URL(string: urlString) else { return }
        downloadGroup.enter()
        downloadImage(url: url) { image in
            if let image {
                result.append(image)
            }
            downloadGroup.leave()
        }
    }
    
    downloadGroup.wait(timeout: .now() + 12)
    DispatchQueue.main.async {
        debugPrint(result)
        result
    }
}
