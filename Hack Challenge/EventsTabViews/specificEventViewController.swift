//
//  specificEventViewController.swift
//  Hack Challenge
//
//  Created by Tiffany Pan on 5/2/22.
//

import UIKit

class specificEventViewController: UIViewController {
    
    var index: Int?
    let viewController = ViewController()
    
    
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
        title.font = UIFont(name: "Montserrat-Medium", size: 25)
        return title
    }()
    
    var locationName: UILabel = {
        let location = UILabel()
        location.textColor = .gray
        location.font = UIFont(name: "Rockwell-Italic", size: 18)
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
    
    // initialize the vc with the cell's information
    init(event: Event, index: Int) {
        super.init(nibName: nil, bundle: nil)
        self.index = index
        titleName.text = event.title
        locationName.text = "📍 " + event.location
        eventImage.sd_setImage(with: URL(string: event.image), placeholderImage: UIImage(named: "shimmering"))
        descriptionView.text = event.description
        dateName.text = "🗓 " + convertUnixToString(date: event.date)
        hostName.text = "🦭 " + event.hostName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        view.backgroundColor = .systemGray6
        
        [contrastView, eventImage, middleSquareView, titleName, locationName, dateName, descriptionView, descriptionLabel, hostName].forEach { subView in
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
}

