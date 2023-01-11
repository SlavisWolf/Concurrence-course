


import UIKit

let downloadGroup = DispatchGroup()
var result = [UIImage]()
var blocks = [DispatchWorkItem]()


for address in urlImages {
    
    guard let url = URL(string: address) else { break }
    
    let time = Double.random(in: 1...4)
    let block = DispatchWorkItem {
        downloadGroup.enter()
        downloadImage(url: url) { image in
            
            if let image {
                result.append(image)
            }
            downloadGroup.leave()
            print("Image downloaded: \(url.path() )")
        }
    }
    
    blocks.append(block)
    print("URL \(address) has been held \(time) seconds")
    // If we use async instead of asyncAfter all tasks enter in the queue and we can't cancel a task after it starts.
    DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + time, execute: block)
}

DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 3) {
    
    // We can only cancel task before they'll be executed, if the task have started we can't cancel it for that we have used asyncAfter when we execute the work items
    blocks.forEach( { $0.cancel() } )
    
    print(result)
    result
}
