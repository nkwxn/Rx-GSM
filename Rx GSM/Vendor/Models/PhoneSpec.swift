//
//  PhoneSpec.swift
//  Rx GSM
//
//  Created by Nicholas on 04/04/22.
//

import Foundation

struct PhoneSpecResponse: Codable {
    let status: Bool?
    let data: PhoneSpec?
    let error: String?
}

struct PhoneSpec: Codable {
    let brand: String
    let phoneName: String
    let thumbnail: String?
    let phoneImages: [String]?
    let releaseDate: String?
    let dimension: String?
    let os: String?
    let storage: String?
    let specifications: [Specification]?
    
    enum CodingKeys: String, CodingKey {
        case brand, thumbnail, dimension, os, storage, specifications
        case phoneName = "phone_name"
        case phoneImages = "phone_images"
        case releaseDate = "release_date"
    }
}

struct Specification: Codable {
    let title: String?
    let specs: [SpecDetail]?
}

struct SpecDetail: Codable {
    let key: String?
    let val: [String]?
}
