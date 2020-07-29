//
//  Parser.swift
//  HeadyTest
//
//  Created by Abhishek Kumar on 27/07/20.
//  Copyright © 2020 Abhishek Kumar. All rights reserved.
//

import Foundation

struct Parser <T>{
        
    func parseData<T: Decodable>(data: Data) -> T?
    {
        let decoder = JSONDecoder()
        do {
            let users = try decoder.decode(T.self, from: data)
            return users
        } catch {
            print(error)
        }
        return nil
    }
}
