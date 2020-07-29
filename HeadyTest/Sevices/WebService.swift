//
//  WebService.swift
//  HeadyTest
//
//  Created by Abhishek Kumar on 27/07/20.
//  Copyright © 2020 Abhishek Kumar. All rights reserved.
//

import Foundation
import Alamofire

class Webservice {

    func fetchData(completion :@escaping (Data?) -> ()) {
        fetchDataFromServer(completion: completion)
    }
    
    func fetchDataFromServer(completion :@escaping (Data?) -> ()) {
        let urlString = AppConstants.apiBaseUrl
        AF.request(urlString).responseData { (response) in
            completion(response.data)
        }
    }
}
