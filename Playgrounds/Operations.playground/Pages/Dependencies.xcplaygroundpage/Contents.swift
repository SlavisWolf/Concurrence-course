
import Foundation
import UIKit

let imageUrls = [
    "https://thumbor.forbes.com/thumbor/fit-in/960x600/https://www.forbes.com/wheels/wp-content/uploads/2022/09/2023_Mercedes-Benz_Sclass_Gallery1.jpg",
    "https://idsb.tmgrup.com.tr/ly/uploads/images/2021/05/30/118050.jpg",
    "https://cdn0.bodas.net/vendor/5749/3_2/960/jpg/3_1_5749.jpeg",
    "https://etimg.etb2bimg.com/thumb/msid-73272260,width-1200,resizemode-4/.jpg",
    "https://thumbor.forbes.com/thumbor/fit-in/960x600/https://www.forbes.com/wheels/wp-content/uploads/2022/01/2022_Genesis_G80_Gallery1.jpg",
]

let queue = OperationQueue()

var downloadedImages = [UIImage]()
var resultImages = [UIImage]()

// WITH A INTERMEDIARY BLOCK
for imageUrl in imageUrls {
    
    guard let url = URL(string: imageUrl) else { break }
    let imageLoad = NetworkOperation(url: url)
    let filter = ImageTransformMono()
    filter.completionBlock = { if let result = filter.outputImage { resultImages.append(result) } }
    let dataTransfer = BlockOperation {
        if let output = imageLoad.imageOutput {
            filter.inputImage = imageLoad.imageOutput
            downloadedImages.append(output)
        }
    }
    dataTransfer.addDependency(imageLoad)
    filter.addDependency(dataTransfer)
    
    
    queue.addOperations([imageLoad, dataTransfer, filter], waitUntilFinished: true)
}


downloadedImages
resultImages

//Without block, check the dependencies in the class
downloadedImages.removeAll()
resultImages.removeAll()

for imageUrl in imageUrls {
    guard let url = URL(string: imageUrl) else { break }
    let imageLoad = NetworkOperation(url: url)
    imageLoad.completionBlock = { if let result = imageLoad.imageOutput { downloadedImages.append(result) } }
    let filter = ImageTransformMono()
    filter.completionBlock = { if let result = filter.outputImage { resultImages.append(result) } }
    filter.addDependency(imageLoad)
    queue.addOperations([imageLoad, filter], waitUntilFinished: true)
}

downloadedImages
resultImages

