import Foundation

public let multiprinter: BlockOperation = {
    
    let multiPrinter = BlockOperation()
    multiPrinter.addExecutionBlock {
        sleep(2)
        print("hi!")
    }
    multiPrinter.addExecutionBlock {
        sleep(2)
        print("who")
    }
    multiPrinter.addExecutionBlock {
        sleep(2)
        print("are")
    }

    multiPrinter.addExecutionBlock {
        sleep(2)
        print("you?")
    }
    
    multiPrinter.completionBlock = {
        print("Multiprinter is over")
    }
    return multiPrinter
}()
