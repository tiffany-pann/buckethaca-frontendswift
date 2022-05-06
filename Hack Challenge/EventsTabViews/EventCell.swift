//
//  EventCell.swift
//  Hack Challenge
//
//  Created by Tiffany Pan on 4/29/22.
//

import UIKit
import SDWebImage

class EventCell: UITableViewCell {
    static let id = "EventCellID"
    
    var eventImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 15
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        return image
    }()
    
    var titleName: UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.textColor = .black
        title.font = UIFont(name: "Montserrat-Medium", size: 25)
        return title
    }()
    
    var heartButton: DOFavoriteButton = {
        let button = DOFavoriteButton()
        button.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        button.image = UIImage(named: "heart")
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        button.imageColorOn = UIColor.systemPink
        return button
    }()
    
    var locationName: UILabel = {
        let location = UILabel()
        location.textColor = .gray
        location.font = UIFont(name: "Rockwell-Italic", size: 16)
        return location
    }()
    
    var dateName: UILabel = {
        let date = UILabel()
        date.textColor = .gray
        date.font = UIFont(name: "Rockwell-Italic", size: 16)
        return date
    }()
    
    var backgroundBox: UIView = {
        let box = UIView()
        box.layer.cornerRadius = 15
        box.backgroundColor = .systemGray6
        box.layer.shadowColor = UIColor.systemGray.cgColor
        box.layer.shadowOpacity = 1
        box.layer.shadowOffset = CGSize(width: 6, height: 10)
        return box
    }()
    
    var backgroundFloatingBox: UIView = {
        let box = UIView()
        box.layer.cornerRadius = 15
        box.backgroundColor = .systemGray4
        return box
    }()
    var hostName: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .gray
        label.font = UIFont(name: "Rockwell-Italic", size: 12)
        return label
    }()
    
    var index: Int?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
        
        [backgroundBox, eventImage, titleName, locationName, dateName, heartButton].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(subView)
        }
        
        let textPadding: CGFloat = 10
        
        NSLayoutConstraint.activate([
            
//            backgroundFloatingBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
//            backgroundFloatingBox.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
//            backgroundFloatingBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
//            backgroundFloatingBox.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 5),
            
            backgroundBox.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: textPadding),
            backgroundBox.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            backgroundBox.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -textPadding),
            backgroundBox.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
//            backgroundBox.heightAnchor.constraint(equalToConstant: 525),
            backgroundBox.widthAnchor.constraint(equalToConstant: 400),
            
            eventImage.leadingAnchor.constraint(equalTo: backgroundBox.leadingAnchor, constant: 5),
            eventImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            eventImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            eventImage.heightAnchor.constraint(equalToConstant: 150),
            eventImage.widthAnchor.constraint(equalToConstant: 150),
            eventImage.trailingAnchor.constraint(equalTo: backgroundBox.trailingAnchor, constant: -5),
            
            titleName.leadingAnchor.constraint(equalTo: eventImage.leadingAnchor, constant: textPadding - 2),
            titleName.topAnchor.constraint(equalTo: eventImage.bottomAnchor, constant: 5),
            titleName.heightAnchor.constraint(equalToConstant: 35),
            titleName.trailingAnchor.constraint(equalTo: heartButton.leadingAnchor),
            
//            hostName.leadingAnchor.constraint(equalTo: titleName.leadingAnchor),
//            hostName.trailingAnchor.constraint(equalTo: titleName.trailingAnchor),
//            hostName.topAnchor.constraint(equalTo: titleName.bottomAnchor, constant: -22),
//            hostName.bottomAnchor.constraint(equalTo: titleName.bottomAnchor, constant: 30),
//            hostName.heightAnchor.constraint(equalToConstant: 30),
            
            heartButton.leadingAnchor.constraint(equalTo: backgroundBox.trailingAnchor, constant: -60),
            heartButton.centerYAnchor.constraint(equalTo: titleName.centerYAnchor),
            heartButton.trailingAnchor.constraint(equalTo: backgroundBox.trailingAnchor, constant: -20),
            
            locationName.leadingAnchor.constraint(equalTo: eventImage.leadingAnchor, constant: textPadding),
            locationName.topAnchor.constraint(equalTo: titleName.bottomAnchor),
            locationName.heightAnchor.constraint(equalToConstant: 20),
            
            dateName.leadingAnchor.constraint(equalTo: eventImage.leadingAnchor, constant: textPadding),
            dateName.topAnchor.constraint(equalTo: locationName.bottomAnchor),
            dateName.heightAnchor.constraint(equalToConstant: 20),
            dateName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
        ])
        
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(event: Event, index: Int) {
        eventImage.sd_setImage(with: URL(string: event.image), placeholderImage: UIImage(named: "shimmering"))
        titleName.text = event.title
        locationName.text = event.location
        hostName.text = "hosted by " + event.hostName
        //figure out which cell is being clicked so i can properly send the correct network request when a user bookmarks an event
        self.index = index
        // see function i wrote in Model to convert between Unix and String
        dateName.text = convertUnixToString(date: event.date)
    }
    
    @objc func tapped(sender: DOFavoriteButton) {
        if sender.isSelected {
//            print("button selected")
            // deselect
            sender.deselect()
        } else {
            // upwrap id 
            if let id = index {
                NetworkManager.bookmarkEvent(id: index!) { Event in
                }
            }
            // select with animation
            // TODO: Post request here to add this event to the users list of bookmarked events
            sender.select()
        }
    }
    
    

}

extension Double {
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: self)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.dateStyle = .medium

        return dateFormatter.string(from: date)
    }
}
