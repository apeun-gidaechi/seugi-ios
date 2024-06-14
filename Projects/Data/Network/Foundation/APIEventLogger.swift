import Alamofire
import Foundation

public class APIEventLogger: EventMonitor {
    
    public func requestDidFinish(_ request: Request) {
        print("🛰 NETWORK Reqeust LOG")
        print(
            "URL: " + (request.request?.url?.absoluteString ?? "") + "\n"
            + "Method: " + (request.request?.httpMethod ?? "") + "\n"
            + "Headers: " + "\(request.request?.allHTTPHeaderFields ?? [:])" + "\n"
        )
        if let str = request.request?.httpBody?.toPrettyPrintedString {
            print("Body: \(str)")
        } else {
            print("Body: is not JSON")
        }
    }
}

public extension Data {
    var toPrettyPrintedString: String? {
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }
        return prettyPrintedString as String
    }
}
