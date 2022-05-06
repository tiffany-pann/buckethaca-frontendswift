//
//  RandomizerViewController.swift
//  Hack Challenge
//
//  Created by Tiffany Pan on 5/6/22.
//

import Foundation
import UIKit
import SDWebImage

import UIKit

class RandomizerViewController: UIViewController {
    
    var index: Int?
    let viewController = ViewController()
    
    let displayingEvent: Event = Event(id: 1, title: "Hi", hostName: "hi", date: 1222, location: "hi", description: "hi", categories: "hi", type: "hi", image: "https://images-hack-challenge.s3.us-east-2.amazonaws.com/3Z70VPN8J02ET89T.png")
    
    var contrastView: UIView = {
        let contrast = UIView()
        contrast.backgroundColor = .white
        contrast.frame = CGRect(x: 0, y: 30, width: 390, height: 800)
        contrast.layer.cornerRadius = 80
//        contrast.layer.shadowColor = UIColor.systemGray.cgColor
//        contrast.layer.shadowOpacity = 1
//        contrast.layer.shadowOffset = CGSize(width: 50, height: 50)
        return contrast
    }()
    
    var eventImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 20
//        image.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        return image
    }()
    
    var titleName: UILabel = {
        let title = UILabel()
        title.textAlignment = .left
        title.textColor = .black
        title.font = UIFont(name: "Montserrat-Medium", size: 40)
        return title
    }()
    
    var locationName: UILabel = {
        let location = UILabel()
        location.textColor = .gray
        location.font = UIFont(name: "Rockwell-Italic", size: 20)
        return location
    }()
    
    var dateName: UILabel = {
        let date = UILabel()
        date.textColor = .gray
        date.font = UIFont(name: "Montserrat-Light", size: 16)
        return date
    }()
    
    var middleSquareView: UIView = {
        let square = UIView()
        square.backgroundColor = .white
        square.layer.cornerRadius = 10
        square.layer.shadowColor = UIColor.systemGray.cgColor
        square.layer.shadowOpacity = 0.8
        square.layer.shadowOffset = CGSize(width: 5, height: 8)
        return square
    }()
    
    var descriptionView: UITextView = {
        let description = UITextView()
        description.backgroundColor = .clear
        description.font = UIFont(name: "Montserrat-Light", size: 20)
        description.isEditable = false
        return description
    }()
    
    var locationIcon: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "location")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var calendarIcon: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(named: "calendar")!
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.layer.shadowColor = UIColor.mintGreenAccent().cgColor
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.layer.shadowOpacity = 0.8
        label.font = UIFont(name: "Montserrat-Medium", size: 25)
        
        return label
    }()
    
    var hostName: UILabel = {
        let host = UILabel()
        host.textColor = .gray
        host.font = UIFont(name: "Rockwell-Italic", size: 20)
        return host
    }()
    
    var heartButton: DOFavoriteButton = {
        let button = DOFavoriteButton()
        button.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        button.image = UIImage(named: "heart")
        button.addTarget(self, action: #selector(tapped), for: .touchUpInside)
        button.imageColorOn = UIColor.systemPink
        return button
    }()
    
    
    override func viewDidLoad() {
        // load view with event info of the current event
        eventImage.sd_setImage(with: URL(string: displayingEvent.image), placeholderImage: UIImage(named: "shimmering"))
        titleName.text = displayingEvent.title
        locationName.text = displayingEvent.location
        hostName.text = "hosted by " + displayingEvent.hostName
        dateName.text = convertUnixToString(date: displayingEvent.date)
        
        
        view.backgroundColor = .systemGray6
        
        [contrastView, eventImage, middleSquareView, titleName, locationName, dateName, descriptionView, descriptionLabel, hostName, heartButton].forEach { subView in
            subView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(subView)
        }
        
        NSLayoutConstraint.activate([
            contrastView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            contrastView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 300),
            contrastView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            contrastView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            eventImage.topAnchor.constraint(equalTo: view.topAnchor),
            eventImage.bottomAnchor.constraint(equalTo: contrastView.bottomAnchor),
            eventImage.leadingAnchor.constraint(equalTo: contrastView.leadingAnchor),
            eventImage.trailingAnchor.constraint(equalTo: contrastView.trailingAnchor),
            
            middleSquareView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 200),
            middleSquareView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 350),
            middleSquareView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 35),
            middleSquareView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -35),
            
            titleName.topAnchor.constraint(equalTo: middleSquareView.topAnchor),
            titleName.bottomAnchor.constraint(equalTo: middleSquareView.bottomAnchor, constant: -80),
            titleName.centerXAnchor.constraint(equalTo: middleSquareView.centerXAnchor),
            
            locationName.topAnchor.constraint(equalTo: titleName.bottomAnchor, constant: 20),
            locationName.bottomAnchor.constraint(equalTo: middleSquareView.bottomAnchor, constant: -30),
            locationName.centerXAnchor.constraint(equalTo: titleName.centerXAnchor),
            
            hostName.topAnchor.constraint(equalTo: titleName.bottomAnchor, constant: -20),
            hostName.bottomAnchor.constraint(equalTo: titleName.bottomAnchor, constant: 30),
            hostName.centerXAnchor.constraint(equalTo: titleName.centerXAnchor),
            
            dateName.topAnchor.constraint(equalTo: locationName.bottomAnchor, constant: -15),
            dateName.bottomAnchor.constraint(equalTo: middleSquareView.bottomAnchor),
            dateName.centerXAnchor.constraint(equalTo: titleName.centerXAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: middleSquareView.bottomAnchor, constant: 20),
            descriptionLabel.bottomAnchor.constraint(equalTo: middleSquareView.bottomAnchor, constant: 60),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            
            descriptionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5),
            descriptionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            descriptionView.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor, constant: -3),
            descriptionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
            
            
            
            
            
        ])
        
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
