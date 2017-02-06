import Foundation
import Moya
import Moya_Marshal
import ReactiveSwift
import Marshal

let regularProvider = MoyaProvider<ExampleAPI>(stubClosure: MoyaProvider.immediatelyStub)
let rcProvider = ReactiveSwiftMoyaProvider<ExampleAPI>(stubClosure: MoyaProvider.immediatelyStub)
let rxProvider = RxMoyaProvider<ExampleAPI>(stubClosure: MoyaProvider.immediatelyStub)

enum ExampleAPI {
    case object
    case array
}

extension ExampleAPI: TargetType {

    var baseURL: URL { return URL(string: "https://www.google.com")! }

    var path: String {
        switch self {
        case .object:
            return "object"
        case .array:
            return "array"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var parameters: [String: Any]? {
        return nil
    }

    var sampleData: Data {
        let fileName: String
        switch self {
        case .object:
            fileName = "object"
        case .array:
            fileName =  "array"
        }
        guard
            let path = Bundle.main.path(forResource: fileName, ofType: "json", inDirectory: ""),
            let dataString = try? String(contentsOfFile: path),
            let data = dataString.data(using: String.Encoding.utf8)
        else { return Data() }
        return data
    }

    var multipartBody: [MultipartFormData]? {
        return nil
    }
    var task: Task {
        return Task.request
    }
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
}
