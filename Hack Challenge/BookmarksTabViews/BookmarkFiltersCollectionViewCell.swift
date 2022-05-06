//
//  BookmarkFiltersCollectionViewCell.swift
//  Hack Challenge
//
//  Created by Tiffany Pan on 5/3/22.
//

import UIKit

class BookmarkFiltersCollectionViewCell: UICollectionViewCell {
    static let id = "BookmarkFiltersCollectionViewCellID"
    
    let padding: CGFloat = 10
    
    let filterLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GillSans-Light", size: 16)
        label.backgroundColor = .systemGray6
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.paddingLeft = 50
        label.paddingRight = 50
        label.paddingTop = 20
        label.paddingBottom = 25
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                filterLabel.backgroundColor = .systemGray6
            } else {
                filterLabel.backgroundColor = UIColor.mintGreenAccent()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(filterLabel)
        
        NSLayoutConstraint.activate([
            filterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            filterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: padding),
            filterLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -10),
            filterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            filterLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(category: bookmarkType) {
        filterLabel.text = category.description
}

}
