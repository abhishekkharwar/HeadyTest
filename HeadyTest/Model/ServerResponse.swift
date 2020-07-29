//
//  ServerResponse.swift
//  HeadyTest
//
//  Created by Abhishek Kumar on 28/07/20.
//  Copyright © 2020 Abhishek Kumar. All rights reserved.
//

import UIKit

struct ServerResponse: Codable {
    let categories: [CategoryResponse]?
    let rankings: [Ranking]?
}

struct Ranking: Codable{
    let ranking: String?
    let products: [ProductRanking]?
}

struct ProductRanking: Codable{
    let id: Int?
    let viewCount: Int?
    let orderCount: Int?
    let shareCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case viewCount = "view_count"
        case orderCount = "order_count"
        case shareCount = "share_count"
    }
}
