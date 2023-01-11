import Foundation


let dispatch = DispatchQueue(label: "com.ajibanez.concurrent", qos: .userInteractive, attributes: .concurrent) // execute all tasks at the same time
let dispatchSerial = DispatchQueue(label: "com.ajibanez.serial") // Execute tasks in order

let item1 = DispatchWorkItem {
    print("Hello beautiful word!")
}


let item2 = DispatchWorkItem {
    print("I will call item 1!!")
    dispatch.async(execute: item1)
}

let item3 = DispatchWorkItem(qos: .userInitiated, flags: .inheritQoS) {
    print("Hello 3")
}

dispatch.async(execute: item3)
dispatchSerial.async(execute: item2)
