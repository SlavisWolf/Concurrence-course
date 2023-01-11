

import Foundation

let group = DispatchGroup()

let workQueue = DispatchQueue(label: "com.ajibanez.concurrent", attributes: .concurrent)


func caseOne() {
    print("Concurrent task 1 start")
    sleep(3)
    print("Concurrent task 1 finish")
}

func caseTwo() {
    print("Concurrent task 2 start")
    sleep(3)
    print("Concurrent task 2 finish")
}

func caseThreeBarrier() {
    print("Concurrent task 3 start (barrier)")
    sleep(3)
    print("Concurrent task 3 finish (barrier)")
}


func caseFour() {
    print("Concurrent task 4 start")
    sleep(3)
    print("Concurrent task 4 finish")
}

func caseFive() {
    print("Concurrent task 5 start")
    sleep(3)
    print("Concurrent task 5 finish")
}

let workItem1 = DispatchWorkItem(block: caseOne)
let workItem2 = DispatchWorkItem(block: caseTwo)
let workItem3Barrier = DispatchWorkItem(qos: .utility, flags: .barrier, block: caseThreeBarrier)
let workItem4 = DispatchWorkItem(block: caseFour)
let workItem5 = DispatchWorkItem(block: caseFive)


// How it works? the tasks before the barrier will be launched at the same time, when both finish, the barrier task is launched and when it is finished the tasks after the barrier will launch with concurrence like the firsts(at same time).

// This is like a serial behavior inside a concurrence queue
workQueue.async(group: group, execute: workItem1)
workQueue.async(group: group, execute: workItem2)
workQueue.async(group: group, execute: workItem3Barrier)
workQueue.async(group: group, execute: workItem4)
workQueue.async(group: group, execute: workItem5)


group.notify(queue: .main) {
    print("All is ok")
}


