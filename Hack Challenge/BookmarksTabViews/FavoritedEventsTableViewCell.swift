//
//  FavoritedEventsTableViewCell.swift
//  Hack Challenge
//
//  Created by Tiffany Pan on 5/1/22.
//

import UIKit

class FavoritedEventsTableViewCell: UITableViewCell {
    static let id = "FavoritedEventsCellID"
    
    let backgroundBox: UIView = {
        let box = UIView()
        box.backgroundColor = .systemGray6
        box.layer.cornerRadius = 15
        return box
    }()
    
    let backgroundFloatingBox: UIView = {
        let box = UIView()
        box.backgroundColor = .systemGray4
        box.layer.cornerRadius = 15
        return box
    }()
    
    let eventImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 5
        image.clipsToBounds = true
        return image
    }()
    
    let eventName: UILabel = {
        let name = UILabel()
        name.textColor = .black
        name.font = UIFont(name: "Montserrat-Medium", size: 20)
        return name
    }()
    
    let eventDate: UILabel = {
        let date = UILabel()
        date.textColor = .gray
        date.font = UIFont(name: "Rockwell-Italic", size: 13)
        return date
    }()
    
    var locationName: String = "Placeholder"
    var descriptionName: String = "Placeholder"
    var hostName: String = "Placeholder"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
//        self.locationName = locationName
//        self.descriptionName = descriptionName
//        self.hostName = hostName
        
        contentView.backgroundColor = .clear
        contentView.layer.shadowColor = UIColor.systemGray4.cgColor
        contentView.layer.shadowOffset = CGSize(width: 10, height: 10)
        
        UIView.animate(withDuration: 2, delay: 0, options: [.repeat, .autoreverse]) {
            self.contentView.layer.shadowOffset = CGSize(width: -2, height: -2)
        } completion: { _ in
            
        }
        contentView.layer.shadowOpacity = 0.7
        
        selectionStyle = .none
        
        [backgroundBox, eventImage, eventName, eventDate].forEach { subView in
            contentView.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let textPadding: CGFloat = 10
        
        
        NSLayoutConstraint.activate([
//            backgroundFloatingBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
//            backgroundFloatingBox.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
//            backgroundFloatingBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
//            backgroundFloatingBox.heightAnchor.constraint(equalToConstant: 100),
            
            backgroundBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: textPadding),
            backgroundBox.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            backgroundBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -textPadding),
            backgroundBox.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            backgroundBox.heightAnchor.constraint(equalToConstant: 100),
            backgroundBox.widthAnchor.constraint(equalToConstant: 400),
            
            eventImage.leadingAnchor.constraint(equalTo: backgroundBox.leadingAnchor, constant: 10),
            eventImage.trailingAnchor.constraint(equalTo: backgroundBox.trailingAnchor, constant: -200),
            eventImage.topAnchor.constraint(equalTo: backgroundBox.topAnchor, constant: 5),
            eventImage.bottomAnchor.constraint(equalTo: backgroundBox.bottomAnchor, constant: -5),
            
            eventName.leadingAnchor.constraint(equalTo: eventImage.trailingAnchor, constant: 10),
            eventName.trailingAnchor.constraint(equalTo: backgroundBox.trailingAnchor, constant: -10),
            eventName.topAnchor.constraint(equalTo: backgroundBox.topAnchor, constant: 30),
            eventName.bottomAnchor.constraint(equalTo: backgroundBox.bottomAnchor, constant: -50),
            
            eventDate.topAnchor.constraint(equalTo: eventName.bottomAnchor),
            eventDate.bottomAnchor.constraint(equalTo: eventName.bottomAnchor, constant: 30),
            eventDate.leadingAnchor.constraint(equalTo: eventName.leadingAnchor),
            eventDate.trailingAnchor.constraint(equalTo: eventImage.trailingAnchor, constant: 400)
            
            
            
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(event: Event) {
        eventImage.sd_setImage(with: URL(string: event.image), placeholderImage: UIImage(named: "shimmering"))
        eventName.text = event.title
        eventDate.text = convertUnixToString(date: event.date)
        locationName = event.location
        descriptionName = event.description
        hostName = event.hostName
    }
    

}
