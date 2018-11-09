//import FSM
import Foma

print("Hello, world!")

let fsm = FSM(fromBinaryFile: "/home/lanes/foma_swift/Foma/demo.bin")
print(fsm.arccount())
//let fsm = FSM(named: "bob")
let word = "cat"
//print(word)

if let result = fsm.apply_down("cat") {
    print("apply_down(\"cat\") returns \(result)")
}

if let result = fsm.apply_down("dog") {
    print("apply_down(\"dog\") returns \(result)")
} else {
    print("failure")
}

//print(fsm.apply_down("cat"))
//print(fsm.apply_down("dog"))

