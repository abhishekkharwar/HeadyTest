//
//  AppConsntant.swift
//  HeadyTest
//
//  Created by Abhishek Kumar on 27/07/20.
//  Copyright © 2020 Abhishek Kumar. All rights reserved.
//

import Foundation
import UIKit

struct AppConstants {
    static let dbModelName:String = "HeadyTest"
    static let apiBaseUrl: String = "https://stark-spire-93433.herokuapp.com/json"
}

struct Cells {
    static let ProductCell = "ProductCell"
}

struct Colors {
    static let yellowColor:UIColor = UIColor(displayP3Red: 242.0/255.0, green: 188.0/255.0, blue: 80.0/255.0, alpha: 1.0)
}

struct DBEntity {
    static let Product = "Product"
    static let Category = "Category"
    static let Variant = "Variant"
}

struct Messages {
    static let NoInternetErrorMessage = "Please check internet connection"
}
