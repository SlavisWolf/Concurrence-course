import UIKit
import Foundation



let myGroup = DispatchGroup()

DispatchQueue.global().async(group: myGroup) {
    print("first!")
}

myGroup.enter()
print("Manually group")
myGroup.leave()


func load(delay: UInt32, completion: () -> () ) {
    sleep(delay)
    completion()
}


myGroup.enter()

load(delay: 2) {
    print("Two seconds of delay")
    myGroup.leave()
}


myGroup.notify(queue: .main) {
    print("All tasks finished")
}
