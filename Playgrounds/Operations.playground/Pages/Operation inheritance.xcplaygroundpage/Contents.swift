
import UIKit

let zugpsitzeImage = UIImage(imageLiteralResourceName: "zugpsitze_mountain.jpg")
let imageTransform = ImageTransformGaussian(image: zugpsitzeImage, radius: 20)
imageTransform.start()
let zugpsitzeOutput = imageTransform.outputImage

// Queues inside queues

let images = ["mountain_1.webp",
              "mountain_2.jpeg",
              "mountain_3.webp",
              "mountain_4.jpeg",
              "mountain_5.jpeg"
].map({ UIImage(imageLiteralResourceName: "mountains/" + $0) })


var filteredImages: [UIImage] = []

let filterQueue = OperationQueue()
let appendQueue = OperationQueue()

for image in images {
    let filterOperation = ImageTransformGaussian(image: image, radius: 20)
    filterOperation.completionBlock = {
        guard let output = filterOperation.outputImage else { return }
        appendQueue.addOperation { filteredImages.append(output) }
    }
    
    filterQueue.addOperation(filterOperation)
}

filterQueue.waitUntilAllOperationsAreFinished()
filteredImages.forEach{
        print($0)
        $0
}
