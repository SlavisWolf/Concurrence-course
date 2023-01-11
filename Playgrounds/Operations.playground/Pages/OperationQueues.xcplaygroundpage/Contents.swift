
import Foundation

let operation1 = BlockOperation { print("I am doing something") }


let queue = OperationQueue()
queue.addOperation(operation1)
queue.addOperation { print("I will do more things") }


let operationQueue2 = OperationQueue()
operationQueue2.addOperation(multiprinter)
