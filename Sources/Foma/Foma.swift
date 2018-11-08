import CFoma

struct Foma {
    var text = "Hello, \(swift_demo())"
    let version = "\(MAJOR_VERSION).\(MINOR_VERSION).\(BUILD_VERSION)\(STATUS_VERSION)"

    struct SpecialSymbols {
        static let Epsilon = EPSILON
        static let Unknown = UNKNOWN
        static let Identity = IDENTITY
    }

    let s1 = fsm_state(state_no: 14, in: 3, out: 4, target: 7, final_state: 0x2A, start_state: 0x2B)

    static let libraryVersion = String(cString: fsm_get_library_version_string())
    /*
    func getLibraryVersion() -> String {
        let result = fsm_get_library_version_string()
        return String(cString: result)
    }
    */


    struct FSM {

        let pointer: UnsafeMutablePointer<fsm>

        init(named name: String) {
            self.pointer = name.withCString{ cstring in
                let mutableCString = UnsafeMutablePointer<Int8>(mutating: cstring)
                return fsm_create(mutableCString)
            }
        }

        init(fromBinaryFile filename: String) {
            self.pointer = filename.withCString{ cstring in
                let mutableCString = UnsafeMutablePointer<Int8>(mutating: cstring)
                return fsm_read_binary_file(mutableCString)
            }
            
        }

        func name() -> String {
            let s = withUnsafeBytes(of: pointer.pointee.name) { (rawPtr) -> String in
                let ptr = rawPtr.baseAddress!.assumingMemoryBound(to: CChar.self)
                return String(cString: ptr)
            }
            return s
        }

        func arity() -> Int32 {
            return pointer.pointee.arity
        }

        func arccount() -> Int32 {
            return pointer.pointee.arccount
        }
        
    }
}
