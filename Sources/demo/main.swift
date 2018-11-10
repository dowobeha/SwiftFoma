//import FSM
import Foma

print("Hello, world!")

//let fsm = FSM(fromBinaryFile: "/Users/lanes/work/yupik/swift/SwiftFoma/demo.bin")
let fsm = FSM(fromBinaryFile: "/Users/lanes/work/yupik/foma.ess.emily/ess.fomabin")
print(fsm.arccount())
//let fsm = FSM(named: "bob")
let word = "cat"
//print(word)
/*
if let result = fsm.apply_down("cat") {
    print("apply_down(\"cat\") returns \(result)")
}

if let result = fsm.apply_down("dog") {
    print("apply_down(\"dog\") returns \(result)")
} else {
    print("failure")
}
*/
//print(fsm.apply_down("cat"))
//print(fsm.apply_down("dog"))


func apply_down(_ underlying_form: String) {

    for result in fsm.apply_down(underlying_form) {
        print("apply_down(\(underlying_form)) = \(result)")
    }
    
/*
    
    if let result = fsm.apply_down(underlying_form) {
        print("apply_down(\(underlying_form)) = \(result)")
    } else {
        print("apply_down(\(underlying_form)) failed")
    }
  */  
}


func apply_up(_ word: String) {

    for result in fsm.apply_up(word) {
        print("apply_up(\(word)) = \(result)")
    }

    /*
    if let result = fsm.apply_up(word) {
        print("apply_up(\(word)) = \(result)")
    } else {
        print("apply_up(\(word)) failed")
    }
    */
}


apply_up("aghnaq")

apply_up("aghnaghaq")


apply_down("aghnagh[N][Abs][Unpd][Sg]")

apply_up("sangami")

//let r = fsm.apply_down(Optional.none)
//print(r.count)
