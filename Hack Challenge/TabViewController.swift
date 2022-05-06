//
//  TabViewController.swift
//  Hack Challenge
//
//  Created by Tiffany Pan on 4/30/22.
//

import UIKit

class TabViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        let tab1 = ViewController()
        let tab1Item = UITabBarItem(title: "Events", image: UIImage(named: "search icon"), selectedImage: UIImage(named: "search icon"))
        tab1.tabBarItem = tab1Item
        
        let tab2 = BookmarksViewController()
        let tab2Item = UITabBarItem(title: "Bookmarks", image: UIImage(named: "bookmarks"), selectedImage: UIImage(named: "bookmarks"))
        tab2.tabBarItem = tab2Item

        let tab3 = BucketListViewController()
        let tab3Item = UITabBarItem(title: "Bucket List", image: UIImage(named: "bucket"), selectedImage: UIImage(named: "bucket"))
        tab3.tabBarItem = tab3Item
        
        let tab5 = ProfileViewController()
        let tab5Item = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), selectedImage: UIImage(named: "profile"))
        tab5.tabBarItem = tab5Item
        
        let tab4 = RandomizerViewController()
        let tab4item = UITabBarItem(title: "Random Event!", image: UIImage(named: "Box Open"), selectedImage: UIImage(named: "Box Open"))
        tab4.tabBarItem = tab4item
        
        self.setViewControllers([tab1, tab2, tab3, tab4, tab5], animated: true)
    
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
           print("Selected \(viewController.title!)")
       }
}
