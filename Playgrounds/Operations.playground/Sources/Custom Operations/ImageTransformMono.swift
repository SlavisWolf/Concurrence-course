
import UIKit
import CoreImage.CIFilterBuiltins

open class ImageTransformMono: Operation {

    public var inputImage: UIImage?
    public var outputImage: UIImage?


    open override func main() {
        
        if inputImage == nil, let networkOpertion = dependencies.first as? NetworkOperation {
            inputImage = networkOpertion.imageOutput
        }
        
        photoEffectMono()
    }

    public func photoEffectMono() {
        guard let inputImage else { return }
        
        let context = CIContext()
        let filter = CIFilter.photoEffectMono()
        filter.inputImage = CIImage(image: inputImage)

        if let output = filter.outputImage, let cgImage = context.createCGImage(output, from: output.extent) {
            outputImage = UIImage(cgImage: cgImage)
        }
    }
}

