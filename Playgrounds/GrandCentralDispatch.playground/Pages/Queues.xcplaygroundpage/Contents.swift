import UIKit

DispatchQueue.main.async {
    print("Main queue")
}


DispatchQueue.global().async {
    print("Global queue")
}

DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 5) {
    print("Global concurrent in five seconds")
}

let serializedDispatch = DispatchQueue(label: "com.ajibanez.serial") // Execute tasks in order

let concurrentDispatch = DispatchQueue(label: "com.ajibanez.concurrent", qos: .userInteractive, attributes: .concurrent) // execute all tasks at the same time


concurrentDispatch.schedule(after: DispatchQueue.SchedulerTimeType(.now() + 86400), tolerance: .seconds(1.0) ) {
    print("Tomorrow action")
}

serializedDispatch.sync {
    print("Hello world")
}

DispatchQueue.concurrentPerform(iterations: 15) { index in
    print("Iteration number: \(index)")
}
