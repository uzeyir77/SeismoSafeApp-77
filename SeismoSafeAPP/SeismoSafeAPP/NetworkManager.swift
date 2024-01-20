//
//  NetworkManager.swift
//  SeismoSafeAPP
//
//  Created by Uzeyir on 15.01.24.
//

import Foundation
import Alamofire
class NetworkManager {
    static func request<T: Codable>(model: T.Type,
                                    endpoint: String,
                                    method: HTTPMethod = .get,
                                    parameters: Parameters? = nil,
                                    encoding: ParameterEncoding = URLEncoding.default,
                                    completion: @escaping((T?, String?) -> Void)) {
        AF.request("\(NetworkHelper.baseURL)\(endpoint)",
                   method: method,
                   parameters: parameters,
                   encoding: encoding,
                   headers: NetworkHelper.header).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                    if let data = response.data, let errorMessage = String(data: data, encoding: .utf8) {
                        print("API error : \(errorMessage)")
                    }
                    completion(nil, error.localizedDescription)
                }
        }
    }
}
