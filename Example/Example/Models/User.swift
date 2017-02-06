import Foundation
import Moya_Marshal
import Marshal

struct User: Unmarshaling {

    let name: String
    let age: String

    init(object: MarshaledObject) throws {
        name = try object.value(for: "user")
        age = try object.value(for: "age")
    }
}

extension User: CustomStringConvertible {
    var description: String {
        return "User: \(name) - \(age)"
    }
}
