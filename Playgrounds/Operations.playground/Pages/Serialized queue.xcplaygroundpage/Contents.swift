
import Foundation

let serializedQueue = OperationQueue()
serializedQueue.maxConcurrentOperationCount = 1

serializedQueue.addOperation {
    sleep(UInt32.random(in: 1...3))
    print("My")
}

serializedQueue.addOperation {
    sleep(UInt32.random(in: 1...3))
    print("name")
}

serializedQueue.addOperation {
    sleep(UInt32.random(in: 1...3))
    print("is")
}

serializedQueue.addOperation {
    sleep(UInt32.random(in: 1...3))
    print("Ralph")
}


serializedQueue.waitUntilAllOperationsAreFinished()
print("First queue finished now, we are going to try barriers!")

let queueBarrier = OperationQueue()

queueBarrier.addOperation {
    sleep(UInt32.random(in: 1...3))
    print("My")
}

queueBarrier.addOperation {
    sleep(UInt32.random(in: 1...3))
    print("name")
}

queueBarrier.addBarrierBlock {
    sleep(UInt32.random(in: 1...3))
    print("Barrier!")
}

queueBarrier.addOperation {
    sleep(UInt32.random(in: 1...3))
    print("is")
}

queueBarrier.addOperation {
    sleep(UInt32.random(in: 1...3))
    print("Ralph")
}
