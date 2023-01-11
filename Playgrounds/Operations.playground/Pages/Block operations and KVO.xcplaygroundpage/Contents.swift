

let operations = Operations()
operations.start(waitUntilFinished: true)
// waitUntilFinished is similar to wait in GCD if we mark it as true, the next print will not be executed until all operations will have finished
print("Its over")

