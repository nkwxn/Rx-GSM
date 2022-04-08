//
//  APIRequest.swift
//  Rx GSM
//
//  Created by Nicholas on 27/03/22.
//

import Foundation

class APIRequest: NSObject {
    
    static func fetchLatestPhones(completion: @escaping ([Phone], String?) -> Void) {
        BaseRequest.GET(url: "https://api-mobilespecs.azharimm.site/v2/latest") { response in
            do {
                if let data = response.data {
                    let phoneModel = try JSONDecoder().decode(PhoneResponse.self, from: data)
                    completion(phoneModel.data?.phones ?? [Phone](), phoneModel.error)
                } else {
                    completion([Phone](), response.error?.localizedDescription)
                }
            } catch {
                print("Error handling JSON content: \(error.localizedDescription)")
            }
        }
    }
    
    static func fetchPhoneSpec(slug: String, completion: @escaping (PhoneSpec?, String?) -> Void) {
        BaseRequest.GET(url: "https://api-mobilespecs.azharimm.site/v2/\(slug)") { response in
            do {
                if let data = response.data {
                    let specModel = try JSONDecoder().decode(PhoneSpecResponse.self, from: data)
                    completion(specModel.data, specModel.error)
                } else {
                    // Completion untuk error localized desc
                    completion(nil, response.error?.localizedDescription)
                }
            } catch {
                print("Error handling JSON Content: \(error.localizedDescription)")
            }
        }
    }
    
    static func fetchBrands() {
        
    }
    
    static func fetchImage(url: String, completion: @escaping (Data?, String?) -> Void) {
        BaseRequest.GET_IMAGE(url: url) { response in
            completion(response.data, response.error?.localizedDescription)
        }
    }
    
    /*
    static func fetchLearningData(url: String,
                                  header: [String: String],
                                  showLoader: Bool,
                                  successCompletion: @escaping (LearningData) -> Void,
                                  failCompletion: @escaping (String) -> Void) {
        // create request
        BaseRequest.GET(url: url, header: header, showLoader: showLoader) { response in
            print(response)
            // prepare the data model
            var dataModel = DataManager.LEARNINGDATA
            
            // handle the response and parsing the data to data model
            do {
                let learningModel = try JSONDecoder().decode(LearningData.self, from: response as! Data)
                dataModel = learningModel
                successCompletion(dataModel!)
            } catch let error { //handle error
                print("error reading json file content: \(error.localizedDescription)")
            }
        }
    }
    */
}
