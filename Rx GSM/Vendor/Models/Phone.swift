//
//  Phone.swift
//  Rx GSM
//
//  Created by Nicholas on 27/03/22.
//

import Foundation

struct PhoneResponse: Codable {
    let status: Bool?
    let data: PhoneDatas?
    let error: String?
}

struct PhoneDatas: Codable {
    let title: String?
    let phones: [Phone]?
}

struct Phone: Codable {
    let phoneName: String
    let slug: String
    let image: String
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case phoneName = "phone_name"
        case slug, image, detail
    }
}
