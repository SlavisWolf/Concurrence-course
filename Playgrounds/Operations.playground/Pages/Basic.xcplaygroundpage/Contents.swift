
import Foundation


let operation1 = BlockOperation {
    
    print("Operation 1 started")
    sleep(2)
    print("Operation 1 finished")
}

operation1.start()
//Concurrent queue all blocks are executed at the same time
multiprinter.start()
