
import UIKit
import CoreImage.CIFilterBuiltins

open class ImageTransformGaussian: Operation {

    public var inputImage: UIImage
    public var radius: Float

    public var outputImage: UIImage?

    public init(image: UIImage, radius: Float) {
        self.inputImage = image
        self.radius = radius
    }

    open override func main() {
        gaussianBlur()
    }

    public func gaussianBlur() {
        let context = CIContext()
        let filter = CIFilter.gaussianBlur()
        filter.radius = radius
        filter.inputImage = CIImage(image: inputImage)

        if let output = filter.outputImage, let cgImage = context.createCGImage(output, from: output.extent) {
            outputImage = UIImage(cgImage: cgImage)
        }
    }
}
