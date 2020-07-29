//
//  TableViewDataSource.swift
//  HeadyTest
//
//  Created by Abhishek Kumar on 27/07/20.
//  Copyright © 2020 Abhishek Kumar. All rights reserved.
//

import Foundation
import UIKit

class DashboardTableViewDataSource<Cell :ProductTableViewCell, Model> : NSObject, UITableViewDataSource {
    
    private var cellIdentifier :String!
    private var items :[Model]!
    var configureCell :(Cell, Model, Int) -> ()
    var configureSectionCount :() -> (Int)
    var configureSection :(Int) -> (String)
    var configureSectionItemCount :(Int) -> (Int)

    init(cellIdentifier :String, items :[Model], configureCell: @escaping (Cell,Model, Int) -> (), configureSection: @escaping (Int) -> (String), configureSectionItemCount: @escaping (Int) -> (Int), configureSectionCount: @escaping () -> (Int)) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
        self.configureSection = configureSection
        self.configureSectionCount = configureSectionCount
        self.configureSectionItemCount = configureSectionItemCount
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return configureSectionCount()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //let item = self.items[section]
        return configureSectionItemCount(section)
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //let item = self.items[section]
        return configureSection(section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! Cell
        let item = self.items[indexPath.section]
        self.configureCell(cell,item, indexPath.row)
        return cell
    }
    
}
