//
//  BaseRequest.swift
//  Rx GSM
//
//  Created by Nicholas on 27/03/22.
//

import Alamofire
import AlamofireImage

class BaseRequest {
    
    static func GET(
        url: String,
        headers: HTTPHeaders? = nil,
        completion: @escaping (DataResponse<Data, AFError>) -> Void
    ) {
        AF.request(url, method: .get, headers: headers)
            .responseDecodable(of: Data.self, completionHandler: completion)
    }
    
    static func POST(
        url: String,
        headers: HTTPHeaders? = nil,
        completion: @escaping (DataResponse<Data, AFError>) -> Void
    ) {
        AF.request(url, method: .post, headers: headers)
            .responseDecodable(of: Data.self, completionHandler: completion)
    }
    
    static func PUT(
        url: String,
        headers: HTTPHeaders? = nil,
        completion: @escaping (DataResponse<Data, AFError>) -> Void
    ) {
        AF.request(url, method: .put, headers: headers)
            .responseDecodable(of: Data.self, completionHandler: completion)
    }
    
    static func GET_IMAGE(url: String, completion: @escaping (AFDataResponse<Image>) -> Void) {
        AF.request(url, method: .get).responseImage(completionHandler: completion)
    }
}
