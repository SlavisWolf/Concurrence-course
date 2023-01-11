
import Foundation

let serialQueue = DispatchQueue(label: "com.ajibanez.serial")

let executeTask: (String, Int) -> () = { title, number in
    print("\(title) task \(number) started")
    sleep(2)
    print("\(title) task \(number) finished")
}

for index in 1...3 {
    serialQueue.async { executeTask("Serial", index) }
}

let concurrentQueue = DispatchQueue(label: "com.ajibanez.concurrent", attributes: .concurrent)

for index in 1...3 {
    concurrentQueue.async { executeTask("Concurrent", index) }
}
