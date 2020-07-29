//
//  WebService.swift
//  AngelBTestCode
//
//  Created by Abhishek Kumar on 27/04/20.
//  Copyright © 2020 Abhishek Kumar. All rights reserved.
//

import Foundation

class Webservice {

    func fetchData(completion :@escaping (Data?) -> ()) {
    
        if AppConstants.shouldFetchLocalData{
            fetchDataFromLoacalStorage(completion: completion)
        }
        else{
            fetchDataFromServer(completion: completion)
        }
    }
    
    func fetchDataFromServer(completion :@escaping (Data?) -> ()) {
        let urlString = AppConstants.baseUrl
            
            let articlesBySourceURL = URL(string: urlString)!
            URLSession.shared.dataTask(with: articlesBySourceURL) { data, _, _ in
                
                if let data = data {
                    
                    DispatchQueue.main.async {
                        completion(data)
                    }
                }
                
            }.resume()
    }
    
    func fetchDataFromLoacalStorage(completion :@escaping (Data?) -> ()) {
        if let filePath = Bundle.main.path(forResource: AppConstants.localJsonFileName, ofType: "json")
        {
            let fileUrl = URL(fileURLWithPath: filePath)
            do{
                let data = try Data(contentsOf: fileUrl)
                completion(data)
            }
            catch{
                completion(nil)
            }
        }
    }
}
