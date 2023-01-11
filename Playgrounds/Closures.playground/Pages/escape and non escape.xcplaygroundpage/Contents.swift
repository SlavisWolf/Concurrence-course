

var array = [() -> ()]()

class Test {
    var x = 10
    
    // Is non escaping because the completion closure is executed in the function's body/scope
    private func nonEscaping(completion: () -> () ) {
        completion()
    }
    
    private func escaping(completion: @escaping () -> () ) {
        array.append(completion)
    }
    
    func testSync() {
        
        nonEscaping {
            x = 20
        }
        
        nonEscaping(completion: { x = 25 })
        
        escaping { print("Ouch") }
        escaping { [weak self] in // if we remove [weak self] we can see that the closures block the deletion from memory of the object and x will be 15 unowned it is not recommended
            self?.x = 15
            print("value of x = \(self?.x ?? 0)")
        }
    }
    
}

do {
    let test1 = Test()

    test1.x
    test1.testSync()
    test1.x
}

array.first?()
array.last?()

