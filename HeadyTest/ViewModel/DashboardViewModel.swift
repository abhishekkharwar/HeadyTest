//
//  UserListViewModel.swift
//  AngelBTestCode
//
//  Created by Abhishek Kumar on 27/04/20.
//  Copyright © 2020 Abhishek Kumar. All rights reserved.
//

import Foundation

class UserListViewModel : NSObject {
    
    private(set) var users :[User] = [User]()
    var bindToSourceViewModels :(() -> ()) = {}
    var showNoResultFound :(() -> ()) = {}
    private var handler :Handler
    
    init(handler :Handler) {
        
        self.handler = handler
        super.init()
        
        // call populate sources
        //populateSources()
    }
    
    func getUsersWithNameString(str: String) {
        if !isQueryBlacklisted(query: str)
        {
            if str.count >= AppConstants.minimumCharactersForSearch
            {
                self.handler.fetchUsers {[weak self] (users) in
                    if let userList = users
                    {
                        self?.users = userList.filter({ (u) -> Bool in
                            return (u.displayName.range(of: str, options: .caseInsensitive) != nil)
                        })
                        self?.bindToSourceViewModels()
                        if self?.users.count == 0
                        {
                            self?.showNoResultFound()
                            self?.addQueryToBlacklist(query: str)
                        }
                    }
                }
            }else{
                clearResults()
            }
        }else{
            clearResults()
            self.showNoResultFound()
        }
    }
    
    func clearResults(){
        self.users.removeAll()
        self.bindToSourceViewModels()
    }
    
    func isQueryBlacklisted(query: String)-> Bool
    {
        let predicate = NSPredicate(format: "text ==[c] %@", query)
        let blackListedQueries = DatabaseManager.sharedManager.fetchObjectsFromEntity(entityName: DBEntity.blackListedQuery, predicate: predicate)
        
        return (blackListedQueries.count > 0)
    }
    
    func addQueryToBlacklist(query: String)
    {
        if let blackListQuery = DatabaseManager.sharedManager.createEntityWithName(entityName: DBEntity.blackListedQuery) as? BlacklistedQuery{
            blackListQuery.text = query
            _ = DatabaseManager.sharedManager.saveChanges()
        }
    }
    
    func user(at index:Int) -> User {
        return self.users[index]
    }
    
    func removeUserFromIndex(index: Int)
    {
        self.users.remove(at: index)
        self.bindToSourceViewModels()
    }
}
