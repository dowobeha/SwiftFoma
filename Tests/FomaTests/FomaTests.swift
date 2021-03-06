import XCTest
@testable import Foma

final class FomaTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
//        XCTAssertEqual(Foma().text, "Hello, 7")
//        print(Foma().version)
        print(Foma.version)
    }

    func testEmptyFSM() {
        let fsm = FSM(named: "bob")
        print(fsm.name())
        print(fsm.arity())
        print(fsm.arccount())
    }

    
    static var allTests = [
      ("testExample", testExample),
      ("testEmptyFSM", testEmptyFSM)
    ]
}
