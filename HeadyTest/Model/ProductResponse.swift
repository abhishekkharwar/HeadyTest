//
//  ProductResponse.swift
//  HeadyTest
//
//  Created by Abhishek Kumar on 28/07/20.
//  Copyright © 2020 Abhishek Kumar. All rights reserved.
//

import UIKit

struct ProductResponse: Codable {
    let id: Int
    let name: String
    let dateAdded: String
    let variants: [VariantResponse]
    let tax: Tax?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case dateAdded = "date_added"
        case variants
        case tax
    }
}

struct Tax: Codable {
    let name: String?
    let value: Float?
}
