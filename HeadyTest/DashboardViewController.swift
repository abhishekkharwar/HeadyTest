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
    @IBOutlet private weak var segmentedControl: UISegmentedControl!
    private var tableViewdataSource :DashboardTableViewDataSource<ProductTableViewCell, Category>!
    private var tableViewdataSourceRanking :DashboardTableViewDataSource<ProductTableViewCell, Product>!
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
    
    @IBAction private func segmentedControlValueChagned(segmentControl: UISegmentedControl)
    {
        if segmentControl.selectedSegmentIndex == 0
        {
            self.dashboardViewModel.bindToSourceViewModels = {
                self.updateDataSource()
            }
            dashboardViewModel.fetchData()
        }else{
            self.dashboardViewModel.bindToSourceViewModels = {
                self.updateDataSourceForRanking()
            }
            if let rankingType = RankingType(rawValue: segmentControl.selectedSegmentIndex){
                dashboardViewModel.fetchDataFromLocalDatabase(rankingType: rankingType)
            }
        }
    }
    
    private func updateDataSource() {
        self.tableViewdataSource = DashboardTableViewDataSource(cellIdentifier: Cells.ProductCell, items: self.dashboardViewModel.categories, configureCell: { (cell, model, index) in
            if let products = model.products{
                if let product = products.allObjects[index] as? Product{
                    cell.nameLabel.text = product.name
//                    print("viewCount = \(product.viewCount)")
//                    print("orderCount = \(product.orderCount)")
//                    print("shareCount = \(product.shareCount)")
                    if let dateAdded = product.dateAdded{
                        cell.dateCreated.text = "Date Added: \(dateAdded)"
                    }
                }
            }
        }, configureSection: { (section) -> (String) in
            let category = self.dashboardViewModel.categories[section]
            return category.name ?? ""
        }, configureSectionItemCount: { (section) -> (Int) in
            let category = self.dashboardViewModel.categories[section]
            return category.products!.count
        }, configureSectionCount: { () -> (Int) in
            return self.dashboardViewModel.categories.count
        })
        self.dashboardTableView.dataSource = self.tableViewdataSource
        self.dashboardTableView.reloadData()
    }
    
    private func updateDataSourceForRanking() {
        self.tableViewdataSourceRanking = DashboardTableViewDataSource(cellIdentifier: Cells.ProductCell, items: self.dashboardViewModel.products, configureCell: { (cell, model, index) in
            let product = self.dashboardViewModel.products[index]
            cell.nameLabel.text = product.name
            
            if self.segmentedControl.selectedSegmentIndex > 0
            {
                switch self.segmentedControl.selectedSegmentIndex{
                case 1:
                    cell.rankingLabel.text = "View Count : \(product.viewCount)"
                case 2:
                    cell.rankingLabel.text = "Order Count : \(product.orderCount)"
                case 3:
                    cell.rankingLabel.text = "Share Count : \(product.shareCount)"
                default:
                    cell.rankingLabel.text = ""
                }
            }else{
                cell.rankingLabel.text = ""
            }
            
            if let dateAdded = product.dateAdded{
                cell.dateCreated.text = "Date Added: \(dateAdded)"
            }
        }, configureSection: { (section) -> (String) in
            return self.headerSectionTitle()
        }, configureSectionItemCount: { (section) -> (Int) in
            return self.dashboardViewModel.products.count
        }, configureSectionCount: { () -> (Int) in
            return 1
        })
        self.dashboardTableView.dataSource = self.tableViewdataSourceRanking
        self.dashboardTableView.reloadData()
    }

    private func headerSectionTitle() -> String{
        switch segmentedControl.selectedSegmentIndex {
        case 1:
            return "Most Viewed"
        case 2:
            return "Most Ordered"
        case 3:
            return "Most Shared"
        default:
            return "All"
        }
    }
}

