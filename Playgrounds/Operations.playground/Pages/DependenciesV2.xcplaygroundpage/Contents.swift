
import Foundation

let url = URL(string: "https://applecoding.com/wp-json/wp/v2/posts")!

let queue = OperationQueue()

let postJSONOperation = NetworkOperation(url: url)

let authorJSONOperation = NetworkOperation()
authorJSONOperation.addDependency(postJSONOperation)

let avatarOperation = NetworkOperation()
avatarOperation.addDependency(authorJSONOperation)

let filter = ImageTransformMono()
filter.addDependency(avatarOperation)

queue.addOperations([postJSONOperation, authorJSONOperation, avatarOperation, filter], waitUntilFinished: true)

filter.outputImage
