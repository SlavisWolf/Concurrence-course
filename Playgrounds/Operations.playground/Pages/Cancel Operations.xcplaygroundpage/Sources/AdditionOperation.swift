import Foundation

open class AdditionOperation: Operation {
    
    
    private let inputArray: [(Int, Int)]
    public var outputArray = [Int]()
    
    public init(inputArray: [(Int, Int)]) {
        self.inputArray = inputArray
        super.init()
    }
    
    open override func main() {
        outputArray = slowAddArray(inputArray) { progress in
            print(String(format: "%.2f%% completed", progress * 100))
            return !self.isCancelled
        }
    }
    
}
