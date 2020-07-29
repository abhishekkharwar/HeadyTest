//
//  TableViewDataSource.swift
//  AngelBTestCode
//
//  Created by Abhishek Kumar on 27/04/20.
//  Copyright © 2020 Abhishek Kumar. All rights reserved.
//

import Foundation
import UIKit

class TableViewDataSource<Cell :UserTableViewCell, Model> : NSObject, UITableViewDataSource {
    
    private var cellIdentifier :String!
    private var items :[Model]!
    var configureCell :(Cell, Model) -> ()
    
    init(cellIdentifier :String, items :[Model], configureCell: @escaping (Cell,Model) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! Cell
        let item = self.items[indexPath.row]
        self.configureCell(cell,item)
        return cell
    }
    
}
