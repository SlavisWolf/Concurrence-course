
import Foundation

let queue = DispatchQueue.global(qos: .userInteractive) // This queue is concurrent, tasks will be executed at the same time
let group = DispatchGroup()

for i in 1...6 {
    
    queue.async(group: group) {
        let time = UInt32.random(in: 2...7)
        print("Task \(i) started in \(time) seconds")
        sleep(time)
        print("Task \(i) finished")
    }
}

print("Hello I'm here")
group.wait(timeout: .now() + 5)
print("I must wait a lot...")
