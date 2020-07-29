//
//  Handler.swift
//  HeadyTest
//
//  Created by Abhishek Kumar on 27/04/20.
//  Copyright © 2020 Abhishek Kumar. All rights reserved.
//

import Foundation

class Handler {
    let webservice = Webservice()
    let parser = Parser<ServerResponse>()
    let databaseManager = DatabaseManager()
    
    func fetchData(completion :@escaping ([Category]?) -> ()) {
        webservice.fetchData {[unowned self] (responseData) in
            if let data = responseData
            {
                if let response:ServerResponse = self.parser.parseData(data: data)
                {
                    self.processAndSaveDataIntoLocalDatabase(serverResponse: response)
                    if let categories = self.databaseManager.fetchObjectsFromEntity(entityName: DBEntity.Category, predicate: nil) as? [Category]{
                        completion(categories)
                    }else{
                        completion(nil)
                    }
                }else{
                    completion(nil)
                }
            }else{
                completion(nil)
            }
        }
    }
    
    func fetchLocalData(completion :@escaping ([Category]?) -> ()) {
        if let categories = self.databaseManager.fetchObjectsFromEntity(entityName: DBEntity.Category, predicate: nil) as? [Category]{
            completion(categories)
        }else{
            completion(nil)
        }
    }
    
    func processAndSaveDataIntoLocalDatabase(serverResponse: ServerResponse)
    {
        if let categories = serverResponse.categories
        {
            for categoryObject in categories
            {
                var category:Category?
                let predicate = NSPredicate(format: "id = %d", categoryObject.id)
                category = databaseManager.fetchObjectsFromEntity(entityName: DBEntity.Category, predicate: predicate).first as? Category
                if category == nil{
                    category = databaseManager.createEntityWithName(entityName: DBEntity.Category) as? Category
                }
                category?.id = Int16(categoryObject.id)
                category?.name = categoryObject.name
                
                let productList = NSMutableSet()
                for productObject in categoryObject.products
                {
                    if let product = saveProducts(productObject: productObject, productList: productList)
                    {
                        if let productRankings = serverResponse.rankings
                        {
                            mapRankingToProduct(rankings: productRankings, product: product)
                        }
                    }
                }
                category?.products = productList
                _ = databaseManager.saveChanges()
            }
        }
    }
    
    func mapRankingToProduct(rankings: [Ranking], product: Product)
    {
        for ranking in rankings
        {
            if let filteredRanking = ranking.products?.filter({ (p) -> Bool in
                return p.id == Int(product.id)
            }){
                for rank in filteredRanking
                {
                    if let orderCount = rank.orderCount{
                        product.orderCount = Double(orderCount)
                    }
                    if let shareCount = rank.shareCount{
                        product.orderCount = Double(shareCount)
                    }
                    if let viewCount = rank.viewCount{
                        product.orderCount = Double(viewCount)
                    }
                }
            }
            
            
        }
    }
    
    func saveProducts(productObject: ProductResponse, productList: NSMutableSet) -> Product?
    {
        var product:Product?
        let predicate = NSPredicate(format: "id = %d", productObject.id)
        product = databaseManager.fetchObjectsFromEntity(entityName: DBEntity.Product, predicate: predicate).first as? Product
        if product == nil{
            product = databaseManager.createEntityWithName(entityName: DBEntity.Product) as? Product
        }
        product?.id = Int16(productObject.id)
        product?.name = productObject.name
        product?.dateAdded = productObject.dateAdded
        productList.add(product!)
                
        let variantList = NSMutableSet()
        for variantObject in productObject.variants
        {
            saveVariants(variantObject: variantObject, variantList: variantList)
        }
        product?.variants = variantList
        return product
    }
    
    func saveVariants(variantObject: VariantResponse, variantList: NSMutableSet)
    {
        var variant:Variant?
        let predicate = NSPredicate(format: "id = %d", variantObject.id)
        variant = databaseManager.fetchObjectsFromEntity(entityName: DBEntity.Variant, predicate: predicate).first as? Variant
        if variant == nil{
            variant = databaseManager.createEntityWithName(entityName: DBEntity.Variant) as? Variant
        }
        
        variant?.id = Int16(variantObject.id)
        if let size = variantObject.size{
            variant?.size = Int16(size)
        }
        variant?.price = Double(variantObject.price)
        variant?.color = variantObject.color
        variantList.add(variant!)
        
    }
}
