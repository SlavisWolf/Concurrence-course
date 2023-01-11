import UIKit

let closure1 = {
    print("Hello world")
}

var x = 10

let closure2 = {
    x += 1
    print("x = \(x)")
}

sleep(2)

closure2()
