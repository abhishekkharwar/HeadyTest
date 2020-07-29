//
//  UserListViewModel.swift
//  HeadyTest
//
//  Created by Abhishek Kumar on 27/07/20.
//  Copyright © 2020 Abhishek Kumar. All rights reserved.
//

import Foundation
import Alamofire

class DashboardViewModel : NSObject {
    
    private(set) var categories :[Category] = [Category]()
    private(set) var products :[Product] = [Product]()
    var bindToSourceViewModels :(() -> ()) = {}
    var showErrorWithMessage :((_ message: String) -> ()) = {_ in }
    private var handler :Handler
    
    init(handler :Handler) {
        
        self.handler = handler
        super.init()
        
        // call populate sources
        //populateSources()
    }
    
    func fetchData(){
        if Alamofire.NetworkReachabilityManager.default!.isReachable{
            self.handler.fetchData {[weak self] (categories) in
                if let categoryList = categories
                {
                    self?.categories = categoryList
                    self?.bindToSourceViewModels()
                }
            }
        }
        else
        {
            showErrorWithMessage(Messages.NoInternetErrorMessage)
        }
    }
    
    func fetchDataFromLocalDatabase(rankingType: RankingType){
        self.handler.fetchLocalData(rankingType: rankingType) {[weak self] (products) in
            if let productList = products
            {
                self?.products = productList
                self?.bindToSourceViewModels()
            }
        }
    }
    
    func category(at index:Int) -> Category {
        return self.categories[index]
    }
    
}
