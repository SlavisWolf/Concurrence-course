
import Foundation

let numberArray: [(Int, Int)] = [(1,2), (3,4), (5,6), (7,8), (9,10), (10,11), (11,12), (13,14), (15,16), (17,18), (19,20)]

let additionOperation = AdditionOperation(inputArray: numberArray)
additionOperation.completionBlock = {
    print(additionOperation.outputArray)
}

let queue = OperationQueue()
queue.addOperation(additionOperation)

sleep(5)
additionOperation.cancel()


