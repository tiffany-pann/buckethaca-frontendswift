//
//  BookmarksViewController.swift
//  Hack Challenge
//
//  Created by Tiffany Pan on 4/30/22.
//

import UIKit

typealias Animation = (UITableViewCell, IndexPath, UITableView) -> Void

class BookmarksViewController: UIViewController {
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
        bookmark.shadowColor = UIColor.mintGreenAccent()
        bookmark.shadowOffset = CGSize(width: 5, height: 3)
        return bookmark
    }()
    
    var contrastView: UIView = {
        let contrast = UIView()
        contrast.backgroundColor = .white
        contrast.frame = CGRect(x: 0, y: 30, width: 390, height: 800)
        contrast.layer.cornerRadius = 50
        contrast.layer.shadowColor = UIColor.systemGray.cgColor
        contrast.layer.shadowOpacity = 1
        contrast.layer.shadowOffset = CGSize(width: 50, height: 50)
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
    
//    let eventsButton: UIButton = {
//        let label = UIButton()
//        label.setTitle("Events", for: .normal)
//        label.setTitleColor(UIColor.systemGray, for: .normal)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .systemGray6
//        label.layer.cornerRadius = 10
//        label.layer.masksToBounds = true
//
//        return label
//    }()
    
//    let bucketButton: UIButton = {
//        let label = UIButton()
//        label.setTitle("Bucketlist", for: .normal)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .systemGray
//        label.layer.cornerRadius = 10
//        label.layer.masksToBounds = true
//        label.addTarget(self, action: #selector(switchToBucketlist), for: .touchUpInside)
//        return label
//    }()
    
        let cellPadding: CGFloat = 15
    
    override func viewDidLoad() {
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        view.backgroundColor = .systemGray6
        
        [contrastView, bookmarksText,bookmarkedEventsTableView].forEach { subView in
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        bookmarkedEventsTableView.dataSource = self
        bookmarkedEventsTableView.delegate = self
        
        NSLayoutConstraint.activate([
            
//            eventsButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 38),
//            eventsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -225),
//            eventsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50),
//
//            bucketButton.leadingAnchor.constraint(equalTo: eventsButton.trailingAnchor, constant: 50),
//            bucketButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60),
//            bucketButton.topAnchor.constraint(equalTo: eventsButton.topAnchor),
            
            contrastView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 65),
            contrastView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contrastView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contrastView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            
//            filtersView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
//            filtersView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
//            filtersView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            filtersView.heightAnchor.constraint(equalToConstant: 50),
            
            bookmarksText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            bookmarksText.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            bookmarksText.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            
            bookmarkedEventsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            bookmarkedEventsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bookmarkedEventsTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            bookmarkedEventsTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
            
        ])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        
        loadBookmarkedEvents()
        // make network request to get bookmarks
        
        
    }
    
//    @objc func switchToBucketlist() {
//        let vc = BookmarkedBucketListViewController()
//        navigationController?.pushViewController(vc, animated: false)
//    }
    
    func loadBookmarkedEvents() {
        NetworkManager.getBookmarkedEvents() { events in
            self.bookmarkedEvents = events.savedEvents
            self.bookmarkedEventsTableView.reloadData()
            }
        }
    }
    
    


extension BookmarksViewController: UITableViewDataSource, UITableViewDelegate {
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewer = specificEventViewController(event: bookmarkedEvents[indexPath.item], index: indexPath.item)
        self.navigationController?.present(viewer, animated: true)
        }
}
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {[weak self] _, _, handler in
//            if let self = self {
//                handler(self.deleteEvent(event: self.bookmarkedEvents[indexPath.item], index: indexPath.item))
//            }
//            handler(false)
//
//            deleteAction.backgroundColor = .systemRed
//            // um wat going on
//
//            return UISwipeActionsConfiguration(actions: [deleteAction])
//        }
//    }
//
//    func deleteEvent(event: Event, index: Int) -> Bool {
//        bookmarkedEvents.remove(at: index)
//        bookmarkedEventsTableView.reloadData()
//
//        return true
//        }
//
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let filters = bookmarkFilters[indexPath.item]
//        guard let index = selectedFilters.firstIndex(where: { checkingFilter in
//            return checkingFilter == filters
//        }) else {
//            return
//        }
//        selectedFilters.remove(at: index)
//    }
//


//extension BookmarksViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return bookmarkFilters.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookmarkFiltersCollectionViewCell.id, for: indexPath) as! BookmarkFiltersCollectionViewCell
//
//        cell.configure(category: bookmarkFilters[indexPath.row])
//
//        return cell
//
//        }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        // change color of background based on the selected tab
//        let filter = bookmarkFilters[indexPath.item]
//        if (filter == .bucketlist) {
//            contrastView.backgroundColor = .mintGreenAccent()
//        } else {
//            contrastView.backgroundColor = .sageAccent()
//        }
//        bookmarkedEventsTableView.reloadData()
//    }
//
//
    
    




