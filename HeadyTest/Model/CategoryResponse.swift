//
//  CategoryResponse.swift
//  HeadyTest
//
//  Created by Abhishek Kumar on 28/07/20.
//  Copyright © 2020 Abhishek Kumar. All rights reserved.
//

import UIKit

struct CategoryResponse: Codable {
    let id: Int
    let name: String
    let products: [ProductResponse]
}
