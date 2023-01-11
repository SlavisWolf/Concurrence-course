

import Foundation



let queue = DispatchQueue(label: "com.ajibanez.concurrent", qos: .userInteractive, attributes: .concurrent)


let semaphore = DispatchSemaphore(value: 4) // value 1 is very similar to a serialized queue, with a value of 4 only 4 task can be executing at the same time

for i in 1...10 {
    queue.async {
        semaphore.wait() // Decreases in one the value of the semaphore if the value is zero it doesn't allow the begining of new task
        print("Process number \(i)")
        sleep(UInt32.random(in: 2...5))
        print("Process finished \(i)")
        semaphore.signal() //Increase the value in one and if value is zero allow to start the next task
    }
}


let group = DispatchGroup()
let resource = Resource(text: "0")
let semaphore2 = DispatchSemaphore(value: 1)
for i in 1...10 {
    
    queue.async(group: group) {
        semaphore2.wait()
        print("Resource number \(i)")
        sleep(UInt32.random(in: 2...5))
        resource.text.append(String(i) )
        print("Resource finished \(i)")
        semaphore2.signal()
    }
}


group.wait()
print(resource.text)
