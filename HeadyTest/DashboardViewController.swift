//
//  ViewController.swift
//  HeadyTest
//
//  Created by Abhishek Kumar on 27/07/20.
//  Copyright © 2020 Abhishek Kumar. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet private weak var dashboardTableView: UITableView!
    private var tableViewdataSource :DashboardTableViewDataSource<ProductTableViewCell, Category>!
    private var dashboardViewModel :DashboardViewModel!

    var handler = Handler()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.handler = Handler()
        self.dashboardViewModel = DashboardViewModel(handler: handler)
        self.dashboardViewModel.bindToSourceViewModels = {
            self.updateDataSource()
        }
        dashboardViewModel.fetchData()
    }

    private func updateDataSource() {
        self.tableViewdataSource = DashboardTableViewDataSource(cellIdentifier: Cells.ProductCell, items: self.dashboardViewModel.categories, configureCell: { (cell, model, index) in
            if let products = model.products{
                if let product = products.allObjects[index] as? Product{
                    cell.nameLabel.text = product.name
                    if let dateAdded = product.dateAdded{
                        cell.dateCreated.text = "Date Added: \(dateAdded)"
                    }
                }
            }
        }, configureSection: { (cateogry) -> (String) in
            return cateogry.name ?? ""
        }, configureSectionItemCount: { (category) -> (Int) in
            category.products!.count
        })
        self.dashboardTableView.dataSource = self.tableViewdataSource
        self.dashboardTableView.reloadData()
    }

}

