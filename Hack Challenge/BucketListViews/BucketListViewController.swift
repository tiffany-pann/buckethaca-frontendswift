//
//  BucketListViewController.swift
//  Hack Challenge
//
//  Created by Tiffany Pan on 4/30/22.
//

import UIKit
import SnapKit

class BucketListViewController: UIViewController {
    
    let completedBucketlist: [Bucket] = [
        Bucket(id: 1, description: "Attend Slope Day!"),
        Bucket(id: 2, description: "Go to the Cornell-Harvard men’s hockey game and throw fish on the ice"),
        Bucket(id: 3, description: "Take off to NYC for Fall Break, being sure to post on Instagram about it at least twice")
    ]

    
    let bucketlistLabel: UILabel = {
        let label = UILabel()
        label.text = "Bucketlist"
        label.font = UIFont(name: "Rockwell-Italic", size: 30)
        label.layer.shadowColor = UIColor.mintGreenAccent().cgColor
        label.layer.shadowOpacity = 1
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.font = UIFont(name: "Montserrat-Medium", size: 30)
        return label
    }()
    
    let bucketlistTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.register(BucketTableViewCell.self, forCellReuseIdentifier: BucketTableViewCell.id)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return tableView
    }()
    
    override func viewDidLoad() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = UIColor.sageAccent()
        [bucketlistLabel, bucketlistTableView].forEach { subView in
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        bucketlistTableView.dataSource = self
        bucketlistTableView.delegate = self
        
        setupConstraints()
        
        
    }
    
    
    private func setupConstraints() {
        bucketlistLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(70)
            make.height.equalTo(30)
        }
        
        bucketlistTableView.snp.makeConstraints { make in
            make.leading.equalTo(bucketlistLabel)
            make.trailing.equalToSuperview().offset(-30)
            make.top.equalTo(bucketlistLabel.snp.bottom).offset(-30)
            make.bottom.equalToSuperview().offset(-80)
        }
        
        
        
    }
}

extension BucketListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allBucketswithStatus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BucketTableViewCell.id, for: indexPath) as! BucketTableViewCell
        cell.configure(bucket: allBucketswithStatus[indexPath.row])
        cell.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? BucketTableViewCell {
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
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
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

    
}
