//
//  AFNetwork.swift
//  Agent
//
//  Created by ibrahim on 26/03/2023.
//

import Foundation
import Alamofire
import ILocalizer

class AFNetwork: SessionDelegate {
    static let shared = AFNetwork()
    private var manager: SessionManager?
    private let baseUrl = "https://dummyjson.com/"
    //MARK: - api request
    
    fileprivate static func getRequest(url: String, parameters: Any , headers: [String: String]?) -> URLRequest {
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
        print(decoded)
        let postData = decoded.data(using: .utf8)
        request.httpBody = postData
        return request
    }
    
    func get<T: Decodable>(url: String, headers: [String:String]? = nil ,type: T.Type, completion: @escaping ( _ error: AppError?, _ response: T?) -> ()) {
        let forUrl = "\(baseUrl)\(url)"
        print("url: \(forUrl)")
        if checkConnection() {
            let safeUrl = forUrl.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)!
            manager = self.getManager()
            manager?.request(safeUrl, method: HTTPMethod.get,encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                switch response.result {
                case .failure:
                    guard let error = response.error else {return}
                    let er = AppError(message: error.localizedDescription)
                    completion(er, nil)
                case .success:
                    guard let data = response.data else {return}
                    print(data.toJSONString())
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    do {
                        let result = try decoder.decode(T.self, from: data)
                        completion(nil, result)
                    } catch {
                        print(error)
                        let er = AppError(message: error.localizedDescription)
                        completion(er, nil)
                    }
                }
            }
        } else {
            let er = AppError(message: "Error")
            completion(er , nil)
        }
    }
    
    func makeRequest<T: Codable>(params: [String:Any]? = nil, headers: [String:String]? = nil,endpoint:String,of: T.Type, completion: @escaping ( _ error: AppError?, _ response: T?) -> ()) {
    //    Animation.shared.animate()
        
        let url = baseUrl + endpoint
        print(url)
        print(params ?? .init())
        if checkConnection() {
            manager = self.getManager()
            manager?.request(url, method: .post, parameters:params , encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                switch response.result {
                case .failure:
                    guard let error = response.error else {return}
                    let er = AppError(message: error.localizedDescription)
                    completion(er, nil)
                case .success:
                    guard let data = response.data else {return}
                    print(data.toJSONString())
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .useDefaultKeys
                    do {
                        let result = try decoder.decode(T.self, from: data)
                        completion(nil, result)
                    } catch {
                        print(error)
                        let er = AppError(message: error.localizedDescription)
                        completion(er, nil)
                    }
                }
            }
        }else {
            let er = AppError(message: "Error")
            completion(er , nil)
        }

    }
    
    func upload<T: Decodable>(url: String, params: [String:Any]?, headers :[String:String]?, images: [UIImage], imageRequestKey: String, type: T.Type,completion: @escaping ( _ error: AppError?, _ response: T?) -> ()) {
        if checkConnection() {
            var url = try! URLRequest(url: URL(string:url)!, method: .post, headers: headers)
            url.timeoutInterval = 200
            manager?.upload(multipartFormData: { multipartFormData in
                if images.count != 0 {
                    for (i, image) in images.enumerated() {
                        let name = "\(Date().timeIntervalSince1970 * 100000)" + "." + "jpg"
                        multipartFormData.append(image.getThumbnial().jpegData(compressionQuality:1)!, withName: "\(imageRequestKey)[\(i)]", fileName: name , mimeType: "image/jpeg")
                    }
                }
                for (key, value) in params ?? [:] {
                    if let val = value as? String {
                        multipartFormData.append(val.data(using: String.Encoding.utf8) ?? .init(), withName: key)
                    }
                    if let val = value as? [String:Any] {
                        let cookieHeader = (val.compactMap({ (key, value) -> String in
                            return "\(key)=\(value)"
                        }) as Array).joined(separator: ";")
                        multipartFormData.append(cookieHeader.data(using: String.Encoding.utf8) ?? .init(), withName: key)
                    }
                }
            }, with: url,
               encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                        print(progress)
                    })
                    upload.responseJSON { response in
                        guard let data = response.data else {return}
                        print(data.toJSONString())
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .useDefaultKeys
                        do {
                            let result = try decoder.decode(T.self, from: data)
                            completion(nil, result)
                        } catch {
                            print(error)
                            let er = AppError(message: error.localizedDescription)
                            completion(er, nil)
                        }
                    }
                    break
                case .failure(let err):
                    let er = AppError(message: err.localizedDescription)
                    completion(er, nil)
                    break
                }
            })
        } else {
            let er = AppError(message: "Error")
            completion(er, nil)
        }
    }
    
     private func getManager() -> SessionManager {

        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "app.sidra.hospital": .disableEvaluation
        ]

        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders

         return Alamofire.SessionManager(
            configuration: configuration,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
    }
    
    private func checkConnection() -> Bool {
        let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")!
        return (reachabilityManager.isReachable)
    }
    
}



