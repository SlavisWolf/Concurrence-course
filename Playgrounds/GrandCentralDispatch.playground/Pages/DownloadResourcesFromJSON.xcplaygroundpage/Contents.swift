
import UIKit

var images: Images?
var result = [UIImage?]()

let group = DispatchGroup()

//Next line configure qos of global queue
let _ = DispatchQueue.global(qos: .userInteractive)

group.enter()
DispatchQueue(label: "com.ajibanez.concurrent", qos: .background, attributes: .concurrent).async {
    
    guard let url = Bundle.main.url(forResource: "images", withExtension: "json"),
            let data = try? Data(contentsOf: url) else {
        group.leave()
        return
    }
    // The json has images of insects, if you have arachnophobia don't open some links, edit the json file in resources folder.
    images = try? JSONDecoder().decode(Images.self, from: data)
    group.leave()
}


group.wait(timeout: .now() + 5)

guard let images else { fatalError("We don't find url images") }
// We do this to keep the order
result = [UIImage?](repeating: nil, count: images.urls.count)


// This is executed in the global queue always
// This method is more efficient for loops
DispatchQueue.concurrentPerform(iterations: images.urls.count) { index in
    group.enter()
    downloadImage(url: images.urls[index]) { image in
        result[index] = image
        group.leave()
    }
}

// For this case we can't use group.wait()  because wait.enter is inside the queue
group.notify(queue: .main) {
    let imagesLoaded = result.compactMap({$0})
    debugPrint(imagesLoaded)
    imagesLoaded
}
