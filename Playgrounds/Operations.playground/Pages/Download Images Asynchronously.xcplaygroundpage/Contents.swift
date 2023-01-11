
import UIKit

let images = [
    "https://thumbor.forbes.com/thumbor/fit-in/960x600/https://www.forbes.com/wheels/wp-content/uploads/2022/09/2023_Mercedes-Benz_Sclass_Gallery1.jpg",
    "https://idsb.tmgrup.com.tr/ly/uploads/images/2021/05/30/118050.jpg",
    "https://cdn0.bodas.net/vendor/5749/3_2/960/jpg/3_1_5749.jpeg",
    "https://etimg.etb2bimg.com/thumb/msid-73272260,width-1200,resizemode-4/.jpg",
    "https://thumbor.forbes.com/thumbor/fit-in/960x600/https://www.forbes.com/wheels/wp-content/uploads/2022/01/2022_Genesis_G80_Gallery1.jpg",
]

var loadedImages: [UIImage] = []
let queue = OperationQueue()

for imagePath in images {
    if let url = URL(string: imagePath) {
        let operation = NetworkOperation(url: url)
        operation.completionBlock = {
            
            var success = false
            if let downloadedImage = operation.imageOutput {
                loadedImages.append(downloadedImage)
                success = true
            }
            print("Finished download of url: \(imagePath) with \(success ? "success" : "error")")
        }
        print("Started download of url: \(imagePath)" )
        queue.addOperation(operation)
    }
}

queue.waitUntilAllOperationsAreFinished()
print(loadedImages)
loadedImages
