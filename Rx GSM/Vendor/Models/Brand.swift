//
//  Brand.swift
//  Rx GSM
//
//  Created by Nicholas on 08/04/22.
//

import Foundation

struct BrandsResponse: Codable {
    let status: Bool?
    let data: [Brand]?
    let error: String?
}

struct Brand: Codable {
    let brandID: Int
    let brandName: String
    let brandSlug: String
    let deviceCount: Int
    let detail: String
    
    enum CodingKeys: String, CodingKey {
        case brandID = "brand_id"
        case brandName = "brand_name"
        case brandSlug = "brand_slug"
        case deviceCount = "device_count"
        case detail
    }
}
