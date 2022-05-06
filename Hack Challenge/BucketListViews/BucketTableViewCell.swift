//
//  BucketTableViewCell.swift
//  Hack Challenge
//
//  Created by Tiffany Pan on 5/3/22.
//

import UIKit

class BucketTableViewCell: UITableViewCell {
    static let id = "BucketTableViewCellID"
    
    var backgroundBox: UIView = {
        let box = UIView()
        box.backgroundColor = UIColor.systemGray6
        box.layer.cornerRadius = 15
        box.layer.shadowColor = UIColor.systemGray.cgColor
        box.layer.shadowOffset = CGSize(width: 4, height: 4)
        box.layer.shadowOpacity = 1
        return box
    }()
    
    var bucketListDescription: UITextView = {
        let description = UITextView()
        description.backgroundColor = .clear
        description.font = UIFont(name: "Montserrat-Light", size: 15)
        description.isEditable = false
        return description
    }()
    
    var heartButton: DOFavoriteButton = {
        let button = DOFavoriteButton()
//        button.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        button.image = UIImage(named: "heart")
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        button.imageColorOn = UIColor.systemPink
        return button
    }()
    
    var checkmarkButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(checkmarkButtonPressed), for: .touchUpInside)
        button.setImage(UIImage(named: "unchecked"), for: .normal)
        button.setImage(UIImage(named: "checked"), for: .selected)
        return button
    }()
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0))
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        contentView.backgroundColor = .clear
        
        [backgroundBox, bucketListDescription, checkmarkButton].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(subView)
        }
        
        NSLayoutConstraint.activate([
            
            backgroundBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            backgroundBox.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            backgroundBox.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backgroundBox.heightAnchor.constraint(equalToConstant: 90),
            
            bucketListDescription.leadingAnchor.constraint(equalTo: backgroundBox.leadingAnchor, constant: 10),
            bucketListDescription.trailingAnchor.constraint(equalTo: backgroundBox.trailingAnchor, constant: -50),
            bucketListDescription.topAnchor.constraint(equalTo: backgroundBox.topAnchor, constant: 5),
            bucketListDescription.bottomAnchor.constraint(equalTo: backgroundBox.bottomAnchor, constant: -20),
            
            checkmarkButton.leadingAnchor.constraint(equalTo: bucketListDescription.trailingAnchor),
            checkmarkButton.topAnchor.constraint(equalTo: bucketListDescription.topAnchor),
            checkmarkButton.bottomAnchor.constraint(equalTo: bucketListDescription.bottomAnchor),
            checkmarkButton.trailingAnchor.constraint(equalTo: backgroundBox.trailingAnchor),

            
//            heartButton.leadingAnchor.constraint(equalTo: bucketListDescription.trailingAnchor),
////            heartButton.trailingAnchor.constraint(equalTo: bucketListDescription.trailingAnchor, constant: 10),
//            heartButton.topAnchor.constraint(equalTo: backgroundBox.topAnchor),
////            heartButton.bottomAnchor.constraint(equalTo: backgroundBox.bottomAnchor),
//            heartButton.widthAnchor.constraint(equalToConstant: 60),
//            heartButton.heightAnchor.constraint(equalToConstant: 60),
            
            
            
        ])
        
    }
    
    func configure(bucket: BucketwithStatus) {
        bucketListDescription.text = bucket.bucketItem.description
        if bucket.status == true {
            checkmarkButton.setImage(UIImage(named: "checked"), for: .normal)
        } else {
            checkmarkButton.setImage(UIImage(named: "unchecked"), for: .normal)
        }
    }
    
    @objc func checkmarkButtonPressed(sender: UIButton) {
        //TODO: Post request here to count this event as completed
        if sender.isSelected {
            // deselect
            checkmarkButton.setImage(UIImage(named: "unchecked"), for: .normal)
        } else {
            // select with animation
            checkmarkButton.setImage(UIImage(named: "checked"), for: .normal)
            // TODO: Post request here to update Bucket.status to true
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapped(sender: DOFavoriteButton) {
        if sender.isSelected {
            // deselect
            sender.deselect()
        } else {
            // select with animation
            sender.select()
        }
    }
}
