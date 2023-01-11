import Foundation

open class AsyncOperation: Operation {
    
    
    //MARK: Data Types
   public enum State: String {
        
        case Ready, Executing, Finished
        
        fileprivate var keyPath: String {
            return "is" + rawValue
        }
        
    }
    
    //MARK: Variables
    public var state: State = .Ready {
        
        willSet {
            willChangeValue(forKey: newValue.keyPath)
            willChangeValue(forKey: state.keyPath)
        }
        
        didSet {
            didChangeValue(forKey: oldValue.keyPath)
            didChangeValue(forKey: state.keyPath)
        }
    }
    
    //MARK: Override variables
    open override var isReady: Bool { super.isReady && state == .Ready }
    open override var isExecuting: Bool { state == .Executing }
    open override var isFinished: Bool { state == .Finished }
    open override var isAsynchronous: Bool { true }
    
    //MARK: Override methods
    
    open override func start() {
        
        guard !isCancelled else {
            state = .Finished
            return
        }
        main()
        state = .Executing
    }
    
    open override func cancel() {
        state = .Finished
    }
    
}
