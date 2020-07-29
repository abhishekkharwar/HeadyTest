//
//  VariantResponse.swift
//  HeadyTest
//
//  Created by Abhishek Kumar on 28/07/20.
//  Copyright © 2020 Abhishek Kumar. All rights reserved.
//

import UIKit

struct VariantResponse: Codable {
    let id: Int
    let color: String
    let size: Int?
    let price: Int
}
