//
//  SearchVC.swift
//  Hack Challenge
//
//  Created by Tiffany Pan on 5/6/22.
//

import UIKit

class searchVC: UIViewController {
    
    let searchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Search"
        navigationItem.searchController = searchController
        
//        searchController.searchResultsUpdater = self
        // 2
        searchController.obscuresBackgroundDuringPresentation = false
        // 3
        searchController.searchBar.placeholder = "Search Candies"
        // 4
        navigationItem.searchController = searchController
        // 5
        definesPresentationContext = true
        
    }
}
