//
//  Handler.swift
//  AngelBTestCode
//
//  Created by Abhishek Kumar on 27/04/20.
//  Copyright © 2020 Abhishek Kumar. All rights reserved.
//

import Foundation

class Handler {
    let webservice = Webservice()
    let parser = Parser<User>()
    let databaseManager = DatabaseManager()
    
    func fetchUsers(completion :@escaping ([User]?) -> ()) {
        webservice.fetchData {[unowned self] (responseData) in
            if let data = responseData
            {
                if let response:ServerResponse<[User]> = self.parser.parseData(data: data)
                {
                    completion(response.users!)
                }else{
                    completion(nil)
                }
            }else{
                completion(nil)
            }
        }
    }
}
