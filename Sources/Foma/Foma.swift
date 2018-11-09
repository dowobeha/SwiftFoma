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

}

public struct FSM {

        let pointer: UnsafeMutablePointer<fsm>

        public init(named name: String) {
            self.pointer = name.withCString{ cstring in
                let mutableCString = UnsafeMutablePointer<CChar>(mutating: cstring)
                return CFoma.fsm_create(mutableCString)
            }
        }

        public init(fromBinaryFile filename: String) {
            self.pointer = filename.withCString{ cstring -> UnsafeMutablePointer<fsm> in
                let mutableCString = UnsafeMutablePointer<CChar>(mutating: cstring)
                return CFoma.fsm_read_binary_file(mutableCString)
            }
        }

        public func name() -> String {
            let s = withUnsafeBytes(of: pointer.pointee.name) { (rawPtr) -> String in
                let ptr = rawPtr.baseAddress!.assumingMemoryBound(to: CChar.self)
                return String(cString: ptr)
            }
            return s
        }

        public func arity() -> Int32 {
            return pointer.pointee.arity
        }

        public func arccount() -> Int32 {
            return pointer.pointee.arccount
        }


        func apply_word(apply_function: (UnsafeMutablePointer<apply_handle>, UnsafeMutablePointer<CChar>) -> UnsafeMutablePointer<CChar>?, word: String) -> String? {

            let handle: UnsafeMutablePointer<apply_handle> = CFoma.apply_init(pointer)

            let possibly_null_result = word.withCString{ (cstring:UnsafePointer<CChar>) -> UnsafeMutablePointer<CChar>? in
                let mutableCString = UnsafeMutablePointer<CChar>(mutating: cstring)

                if let function_result:UnsafeMutablePointer<CChar> = apply_function(handle, mutableCString) {
                    return function_result
                } else {
                    return Optional.none
                }

            }

            let result:String? 
            
            if (possibly_null_result==Optional.none) {
                result = Optional.none
            } else {
                result = String(cString: possibly_null_result!)
            }
            
            CFoma.apply_clear(handle)
            return result

        }

        
        public func apply_down(_ word: String) -> String? {
            return apply_word(apply_function: CFoma.apply_down, word: word)
        }
        
        public func apply_up(_ word: String) -> String? {
            return apply_word(apply_function: CFoma.apply_up, word: word)
        }

}


