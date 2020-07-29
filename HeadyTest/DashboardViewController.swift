//
//  ViewController.swift
//  HeadyTest
//
//  Created by Abhishek Kumar on 27/07/20.
//  Copyright © 2020 Abhishek Kumar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let handler = Handler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        handler.fetchData { (response) in
            if let categories = response
            {
                for category in categories
                {
                    if let products = category.products?.allObjects as? [Product]
                    {
                        for product in products
                        {
                            print("Category = \(category.name!), Product = \(product.name!)" as Any)
                        }
                    }
                }
            }
        }
        
    }


}

