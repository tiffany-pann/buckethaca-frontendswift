//
//  ViewController.swift
//  Hack Challenge
//
//  Created by Tiffany Pan on 4/28/22.
//

import UIKit
import Alamofire


class ViewController: UIViewController {
    
    let searchController = UISearchController()
    
    let reuseIdentifier = "ReuseableFilterIdentifier"
    let reuseableEventsIdentifier = "ReuseableEventIdentifier"
    let allFilters: [Category] = []
    let padding: CGFloat = -5
    let cellPadding: CGFloat = 15
    
    var allEvents: [Event] = [
//        Event(id: 1, title: "hi", date: 1651557725, time: 1651557725, location: "blah", description: "dskjfhsdjfhdsjf", categories: [.academic], type: "events", image: Image(url: "https://images-hack-challenge.s3.us-east-2.amazonaws.com/3Z70VPN8J02ET89T.png", createdAt: "hi"))
    ]
    
    lazy var shownEvents: [Event] = allEvents
    let allCategories: [String] = ["Academic", "Indoors", "Libaries", "Outdoors", "Clubs", "Sports"]

//    let allCategories: [Category] = [
//        // TODO: If things break fix this lmao
//        .academic, .indoors, .library, .outdoors
//    ]
    var selectedCategories: [String] = []
    
    let refreshControl = UIRefreshControl()
    
    
    var currentIndexPathToUpdate: IndexPath? // We use this for updating and deleting
    
    var searchBar: UITextField = {
        let searchBar = UITextField()
        searchBar.backgroundColor = .clear
        searchBar.placeholder = "           Search by Event Name"
        searchBar.text = "      "
        searchBar.layer.cornerRadius = 21
        searchBar.clearButtonMode = .whileEditing
        searchBar.font = .systemFont(ofSize: 15)
        searchBar.backgroundColor = .systemGray6
        return searchBar
    }()
    
    
    var addButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGray
        button.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        return button
    }()
    
    
    var gradientLine: UIView = {
        let gradientLine = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 8))
        
        let gradient = CAGradientLayer()
        gradient.frame = gradientLine.bounds
        gradient.colors = [UIColor.systemGray5.cgColor, UIColor.white.cgColor]
        
        gradientLine.layer.insertSublayer(gradient, at: 0)
        return gradientLine
    }()
    
    lazy var filtersView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.sectionInset = UIEdgeInsets(top: cellPadding, left: cellPadding, bottom: cellPadding, right: cellPadding)
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(FiltersCollectionViewCell.self, forCellWithReuseIdentifier: FiltersCollectionViewCell.id)
        collectionView.dataSource = self
        collectionView.allowsMultipleSelection = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    lazy var allEventsView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.sageGreenBackground()
        tableView.register(EventCell.self, forCellReuseIdentifier: EventCell.id)
        tableView.dataSource = self
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 550
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.addSubview(refreshControl)
        
        return tableView
    }()
    
    var searchButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        button.tintColor = UIColor.sageGreenBackground()
        return button
    }()
    
    var clearSearchButton: UIButton =  {
        let button = UIButton()
        button.addTarget(self, action: #selector(clearSearch), for: .touchUpInside)
        return button
    }()
    
    let alert = UIAlertController(title: "No events found ☹️", message: "Please try searching again!", preferredStyle: UIAlertController.Style.alert)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        alert.addAction(UIAlertAction(title: "OK!", style: UIAlertAction.Style.default, handler: nil))
        
        searchBar.delegate = self
        
        loadAllEvents()
//        refreshData()
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        view.backgroundColor = .white
        
        allEventsView.backgroundColor = .clear
        lazy var addButtonImage = UIImage(named: "add")
        addButton.setImage(addButtonImage, for: .normal)
        searchButton.setImage(UIImage(named: "green search icon"), for: .normal)
        clearSearchButton.setImage(UIImage(named: "reload"), for: .normal)
        
        //        [allEventsView].forEach { subView in
        //            view.addSubview(subView)
        //            subView.translatesAutoresizingMaskIntoConstraints = false
        //        }
        
        [searchBar, gradientLine, allEventsView, filtersView, addButton, searchButton, clearSearchButton].forEach { subView in
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
       
        
        // Do any additional setup after loading the view.
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -padding),
            searchBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 60),
            searchBar.widthAnchor.constraint(equalToConstant: 240),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            searchButton.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: 5),
            searchButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 35),
            searchButton.widthAnchor.constraint(equalToConstant: 35),
            
            addButton.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: 45),
            addButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 35),
            addButton.widthAnchor.constraint(equalToConstant: 35),
            
            clearSearchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            clearSearchButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            clearSearchButton.heightAnchor.constraint(equalToConstant: 35),
            clearSearchButton.widthAnchor.constraint(equalToConstant: 35),
            
            
            filtersView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 5),
            filtersView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            filtersView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            filtersView.heightAnchor.constraint(equalToConstant: 50),
            
            gradientLine.topAnchor.constraint(equalTo: filtersView.bottomAnchor, constant: 8),
            gradientLine.heightAnchor.constraint(equalToConstant: 5),
            gradientLine.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            gradientLine.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            
            allEventsView.topAnchor.constraint(equalTo: gradientLine.bottomAnchor, constant: -35),
            allEventsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            allEventsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            allEventsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            allEventsView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    // refreshes TableView every time the view appears
    override func viewDidAppear(_ animated: Bool) {
        loadAllEvents()
    }
    
    func loadAllEvents() {
        // use getAllEvents in Network Manager
        NetworkManager.getAllEvents { events in
            self.allEvents = events.events
            self.shownEvents = self.allEvents
            self.sortEventData()
            self.allEventsView.reloadData()
        }
    }
    
    @objc func refreshData() {
        NetworkManager.getAllEvents { events in
            self.allEvents = events.events
            self.shownEvents = self.allEvents
            self.sortEventData()
            self.allEventsView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    @objc func addButtonPressed() {
        UIView.animate(withDuration: 0.3,
                       animations: {
            self.addButton.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
                       completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.addButton.transform = CGAffineTransform.identity
            }
        })
        
        navigationController?.present(addEventViewController(), animated: true)
        
        
    }
    
    @objc func searchButtonPressed() {
        if let searchingString = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines), searchingString != "" {
            searchBar.resignFirstResponder()
            NetworkManager.searchEvents(eventName: searchingString, completion: { [self] events in
                if events.events.isEmpty {
                    self.present(alert, animated: true, completion: nil)
                } else {
                    searchBar.text = ""
                    self.shownEvents = events.events
                    self.sortEventData()
                    self.allEventsView.reloadData()
                    self.refreshControl.endRefreshing()
                }
                
            })
                                    
        }
    }
    
    @objc func clearSearch() {
        NetworkManager.getAllEvents { events in
            self.shownEvents = events.events
            self.sortEventData()
            self.allEventsView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        allEventsView.fadeEdges(with: 0.8)
    }
    
    
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FiltersCollectionViewCell.id, for: indexPath) as! FiltersCollectionViewCell
        
        cell.configure(category: allCategories[indexPath.row])
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categories = allCategories[indexPath.item]
        
        selectedCategories.append(categories)
        
        
        shownEvents = allEvents.filter({ event in
            selectedCategories.description.contains(event.categories.description)
        })
        
        allEventsView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let categories = allCategories[indexPath.item]
        
        
        guard let index = selectedCategories.firstIndex(where: { checkingCategory in
            return checkingCategory == categories
        }) else {
            return
        }
        
        selectedCategories.remove(at: index)
        
        if (selectedCategories.isEmpty) {
            shownEvents = allEvents
        } else {
            shownEvents = allEvents.filter({ event in
                return selectedCategories.contains(event.categories)
            })
            
        }
        
        allEventsView.reloadData()
    }
    
    func sortEventData() {
        allEvents.sort { (leftEvent, rightEvent) -> Bool in
            return leftEvent.date > rightEvent.date
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.id, for: indexPath) as! EventCell
        cell.configure(event: shownEvents[indexPath.item], index: indexPath.row + 1)
        return cell
    }
    
}
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    // creates the white space in between each table view cell
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerColor: UIView = {
            let header = UIView()
            header.backgroundColor = .clear
            return header
        }()
        return headerColor
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewer = specificEventViewController(event: shownEvents[indexPath.item], index: indexPath.item)
        
        navigationController?.present(viewer, animated: true)
    }
    
}

extension UITableView {
    
    func fadeEdges(with modifier: CGFloat) {
        
        let visibleCells = self.visibleCells
        
        guard !visibleCells.isEmpty else { return }
        guard let topCell = visibleCells.first else { return }
        guard let bottomCell = visibleCells.last else { return }
        
        visibleCells.forEach {
            $0.contentView.alpha = 1
        }
        
        let cellHeight = topCell.frame.height - 1
        let tableViewTopPosition = self.frame.origin.y
        let tableViewBottomPosition = self.frame.maxY
        
        guard let topCellIndexpath = self.indexPath(for: topCell) else { return }
        let topCellPositionInTableView = self.rectForRow(at:topCellIndexpath)
        
        guard let bottomCellIndexpath = self.indexPath(for: bottomCell) else { return }
        let bottomCellPositionInTableView = self.rectForRow(at: bottomCellIndexpath)
        
        let topCellPosition = self.convert(topCellPositionInTableView, to: self.superview).origin.y
        let bottomCellPosition = self.convert(bottomCellPositionInTableView, to: self.superview).origin.y + cellHeight
        let topCellOpacity = (1.0 - ((tableViewTopPosition - topCellPosition) / cellHeight) * modifier)
        let bottomCellOpacity = (1.0 - ((bottomCellPosition - tableViewBottomPosition) / cellHeight) * modifier)
        
        topCell.contentView.alpha = topCellOpacity
        bottomCell.contentView.alpha = bottomCellOpacity
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("begin editing")
        textField.tintColor = .blue
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("end editing")
        textField.tintColor = .clear
    }
}
