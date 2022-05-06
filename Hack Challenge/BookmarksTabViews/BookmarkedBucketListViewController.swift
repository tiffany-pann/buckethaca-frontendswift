//
//  BookmarkedBucketListViewController.swift
//  Hack Challenge
//
//  Created by Tiffany Pan on 5/4/22.
//
import UIKit

class BookmarkedBucketListViewController: UIViewController {
//    lazy var selectedFilters: [bookmarkType] = []
        
    // dummy data
//    [
//        Event(id: "2", title: "Club Fest", description: "Come to Club Fest and check out all of the cool clubs that Cornell have to offer!", poster: "Tiffany Pan", location: "Arts Quad", timeStamp: "05/01/2022", filters: [.outdoors], image: UIImage(named: "clubfest")!, date: "May 1st, 2022"),
//
//        Event(id: "3", title: "Slope Day", description: "blah", poster: "Tiffany Pan", location: "The Slope", timeStamp: "05/11/2022", filters: [.outdoors], image: UIImage(named:"slopeday")!, date: "May 11th, 2022"),
//
//        Event(id: "1", title: "Eugene Lee Yang", description: "blah", poster: "Kelly Tran", location: "Barton Hall", timeStamp: "04/30/22", filters: [.indoors], image: UIImage(named: "eugene")!, date: "May 7th, 2022"),
//    ]
    lazy var bookmarkedEvents: [Event] = [
    
        ]
    
    var bookmarksText: UILabel = {
        let bookmark = UILabel()
        bookmark.text = "Bookmarks"
        bookmark.textColor = .black
        bookmark.font = UIFont(name: "Rockwell-Italic", size: 30)
        return bookmark
    }()
    
    var contrastView: UIView = {
        let contrast = UIView()
        contrast.backgroundColor = .systemGray6
        contrast.frame = CGRect(x: 0, y: 30, width: 390, height: 800)
        contrast.layer.cornerRadius = 50

//        contrast.layer.shadowColor = UIColor.systemGray.cgColor
//        contrast.layer.shadowOpacity = 1
//        contrast.layer.shadowOffset = CGSize(width: 50, height: 50)
        return contrast
    }()
    
    var bookmarkedEventsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(FavoritedEventsTableViewCell.self, forCellReuseIdentifier: FavoritedEventsTableViewCell.id)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        tableView.isScrollEnabled = true
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    let eventsButton: UIButton = {
        let label = UIButton()
        label.setTitle("Events", for: .normal)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemGray
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.addTarget(self, action: #selector(switchToEventlist), for: .touchUpInside)
        return label
    }()
    
    let bucketButton: UIButton = {
        let label = UIButton()
        label.setTitle("Bucketlist", for: .normal)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setTitleColor(UIColor.systemGray, for: .normal)
        label.backgroundColor = .systemGray6
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        return label
    }()
    
    
    let cellPadding: CGFloat = 15
    
    override func viewDidLoad() {
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        view.backgroundColor = .systemGray3
        
        [eventsButton, bucketButton, contrastView, bookmarkedEventsTableView].forEach { subView in
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        bookmarkedEventsTableView.dataSource = self
        bookmarkedEventsTableView.delegate = self
        
        NSLayoutConstraint.activate([
            
            eventsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 38),
            eventsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -225),
            eventsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
            
            bucketButton.leadingAnchor.constraint(equalTo: eventsButton.trailingAnchor, constant: 50),
            bucketButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60),
            bucketButton.topAnchor.constraint(equalTo: eventsButton.topAnchor),
            
            contrastView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 65),
            contrastView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contrastView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contrastView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            
//            filtersView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
//            filtersView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
//            filtersView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            filtersView.heightAnchor.constraint(equalToConstant: 50),
            
//            bookmarksText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            bookmarksText.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
//            bookmarksText.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            bookmarkedEventsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            bookmarkedEventsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bookmarkedEventsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            bookmarkedEventsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
            
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        // make network request to get bookmarks
        
        
    }
    
    @objc func switchToEventlist() {
        let vc = TabViewController()
        // TO DO how to make TabBarViewController always ppear 
        navigationController?.pushViewController(vc, animated: false)
    }
    
    
    
}

extension BookmarkedBucketListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarkedEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritedEventsTableViewCell.id, for: indexPath) as! FavoritedEventsTableViewCell
        cell.configure(event: bookmarkedEvents[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? FavoritedEventsTableViewCell {
            let delay = 0.05 * Double(indexPath.row)
            cell.transform = CGAffineTransform(translationX: tableView.bounds.width, y: 0)
                    UIView.animate(
                        withDuration: 0.8,
                        delay: delay,
                        usingSpringWithDamping: 0.8,
                        initialSpringVelocity: 0.1,
                        options: [.curveEaseInOut],
                        animations: {
                            cell.transform = CGAffineTransform.identity
            })
        }
    }
}
