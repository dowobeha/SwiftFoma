import CFoma


public struct Foma {

    private init() { /* This space intentionally left blank. This constructor should never be called. */ }
    
    public static let MAJOR_VERSION: Int = Int(CFoma.MAJOR_VERSION)
    public static let MINOR_VERSION: Int = Int(CFoma.MINOR_VERSION)
    public static let BUILD_VERSION: Int = Int(CFoma.BUILD_VERSION)
    public static let STATUS_VERSION: String = CFoma.STATUS_VERSION 

    public static let version: String = String(cString: CFoma.fsm_get_library_version_string())
    
    public struct SpecialSymbols {
        public static let Epsilon = EPSILON
        public static let Unknown = UNKNOWN
        public static let Identity = IDENTITY
    }

}


public class FSM {

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

        deinit {
            CFoma.fsm_destroy(self.pointer)
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


        func apply_once(_ handle: UnsafeMutablePointer<apply_handle>, _ apply_function: (UnsafeMutablePointer<apply_handle>, UnsafeMutablePointer<CChar>?) -> UnsafeMutablePointer<CChar>?, _ possibleWord: String?) -> String? {

            let possibly_null_result: UnsafeMutablePointer<CChar>?

            if let word = possibleWord {
                                
                possibly_null_result = word.withCString{ (cstring:UnsafePointer<CChar>) -> UnsafeMutablePointer<CChar>? in
                    let mutableCString = UnsafeMutablePointer<CChar>(mutating: cstring)

                    if let function_result:UnsafeMutablePointer<CChar> = apply_function(handle, mutableCString) {
                        return function_result
                    } else {
                        return Optional.none
                    }

                }
              
            } else {

                possibly_null_result = apply_function(handle, Optional.none)
                
            }
                        
            let result:String? 
            
            if (possibly_null_result==Optional.none) {
                result = Optional.none
            } else {
                result = String(cString: possibly_null_result!)
            }

            return result
        }

        func apply_word(apply_function: (UnsafeMutablePointer<apply_handle>, UnsafeMutablePointer<CChar>?) -> UnsafeMutablePointer<CChar>?, word: String?) -> [String] {

            let handle: UnsafeMutablePointer<apply_handle> = CFoma.apply_init(pointer)

            var results = [String]()           

            var input: String? = word // The first time we call the function, we want to use what the user provided

            while let current_result:String = apply_once(handle, apply_function, input) {

                results.append(current_result)

                input = Optional.none // After the first time, we need to use a null pointer (Optional.none) to tell foma that we want the rest of the results (if there are any)
                
            }

            CFoma.apply_clear(handle)

            return results
            
            /*
            while True {

                if let current_result:String = apply_once(handle, apply_function, input) {
                    results.append(current_result)
                } else {
                    CFoma.apply_clear(handle)
                    return results
                }

                
                
            }
*/
        }

        
        public func apply_down(_ word: String) -> [String] {
            return apply_word(apply_function: CFoma.apply_down, word: word)
        }
        
        public func apply_up(_ word: String) -> [String] {
            return apply_word(apply_function: CFoma.apply_up, word: word)
        }

}


