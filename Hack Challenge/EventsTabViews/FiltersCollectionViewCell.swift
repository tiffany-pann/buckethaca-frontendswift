//
//  FiltersCollectionViewCell.swift
//  Hack Challenge
//
//  Created by Tiffany Pan on 4/29/22.
//

import UIKit

class FiltersCollectionViewCell: UICollectionViewCell {
    static let id = "FiltersCollectionViewCellID"
    
    let padding: CGFloat = 10
    
    let filterLabel: PaddingLabel = {
        let label = PaddingLabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "GillSans-Light", size: 16)
        label.backgroundColor = .systemGray6
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.paddingLeft = 15
        label.paddingRight = 15
        label.paddingTop = 15
        label.paddingBottom = 15
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                filterLabel.backgroundColor = UIColor.mintGreenAccent()
            } else {
                filterLabel.backgroundColor = .systemGray6
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(filterLabel)
        contentView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            filterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            filterLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: padding),
            filterLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            filterLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            filterLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(category: String) {
        filterLabel.text = category
}

}
