import Foundation

public class Operations: NSObject {
    
    
    let block1 = BlockOperation { defaultOperation(number: 1) }
    let block2 = BlockOperation { defaultOperation(number: 2) }
    let block3 = BlockOperation { defaultOperation(number: 3) }
    let block4 = BlockOperation { defaultOperation(number: 4) }
    
    let queue = OperationQueue()
    
    var observation: NSKeyValueObservation?
    
    private static func defaultOperation(number: Int) {
        let time = UInt32.random(in: 1...3)
        print("Loading \(number)")
        sleep(time)
        print("\(number) loaded in \(time) seconds")
    }
    
    public func start(waitUntilFinished: Bool = false) {
        
        
        //Depends on the version maybe you need to add @objc prefix to block2 var if not in some versions this doesn't work
        observation = block2.observe(\.isFinished) { object, range in
            print("Block2 finished")
        }
        
        queue.addOperations([block1, block2, block3, block4], waitUntilFinished: waitUntilFinished)
    }
}
