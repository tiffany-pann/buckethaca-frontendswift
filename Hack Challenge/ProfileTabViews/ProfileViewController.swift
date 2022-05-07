//
//  ProfileViewController.swift
//  Hack Challenge
//
//  Created by Tiffany Pan on 4/30/22.
//

import UIKit
import GoogleSignIn
import SDWebImage

class ProfileViewController: UIViewController {
    
    let profileLabel: UILabel = {
        let label = UILabel()
        label.text = "Profile"
        label.font = UIFont(name: "Rockwell-Italic", size: 30)
        label.layer.shadowColor = UIColor.mintGreenAccent().cgColor
        label.layer.shadowOpacity = 1
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        label.font = UIFont(name: "Montserrat-Medium", size: 30)
        return label
    }()
    
    let userLogoutButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(LogOut), for: .touchUpInside)
        button.contentMode = .scaleAspectFit
        button.setTitle("Sign Out", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = . systemGray6
        button.layer.shadowColor = UIColor.systemGray.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: 6, height: 10)
        button.layer.cornerRadius = 10
        return button
    }()
    
    let userImage: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 87.5
        image.image = UIImage(named: "appa")
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.borderWidth = 2
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image

    }()
    
    let userNameLabel: UILabel = {
        let name = UILabel()
        if let googleName = GIDSignIn.sharedInstance.currentUser?.profile?.name {
            name.text = "🙋🏻‍♀️ \(googleName)"
        }
        name.font = UIFont(name: "Rockwell-Italic", size: 30)
        return name
    }()
    
    let userEmailLabel: UILabel = {
        let email = UILabel()
        if let googleEmail = GIDSignIn.sharedInstance.currentUser?.profile?.email {
            email.text = "📧 \(googleEmail)"
        }
        email.font = UIFont(name: "Montserrat-Medium", size: 20)
        return email
    }()
    
    let contrastView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var gradientLine: UIView = {
        let gradientLine = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 20))
        
        let gradient = CAGradientLayer()
        gradient.frame = gradientLine.bounds
        gradient.colors = [UIColor.profileGreen().cgColor, UIColor.white.cgColor]
        
        gradientLine.layer.insertSublayer(gradient, at: 0)
        return gradientLine
    }()
    
    override func viewDidLoad() {
        
//        userImage.sd_setImage(with: String(returnUserImage()?), placeholderImage: "clubfest")
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = UIColor.profileGreen()
        [contrastView, profileLabel, userLogoutButton, userNameLabel, userImage, userEmailLabel].forEach { subView in
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        profileLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.top.equalToSuperview().offset(70)
            make.height.equalTo(30)
        }
        
        NSLayoutConstraint.activate([
            contrastView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 220),
            contrastView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contrastView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contrastView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
//            gradientLine.topAnchor.constraint(equalTo: contrastView.topAnchor),
//            gradientLine.bottomAnchor.constraint(equalTo: contrastView.topAnchor, constant: 100),
//            gradientLine.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            gradientLine.trailingAnchor.constraint(equalTo: view.trailingAnchor),
    
            userImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userImage.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 80),
            userImage.heightAnchor.constraint(equalToConstant: 175),
            userImage.widthAnchor.constraint(equalToConstant: 175),
            
            userNameLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            userNameLabel.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 65),
            userNameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            userEmailLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            userEmailLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 30),
            userEmailLabel.heightAnchor.constraint(equalToConstant: 10),
            
            userLogoutButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 140),
            userLogoutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -140),
            userLogoutButton.topAnchor.constraint(equalTo: userEmailLabel.bottomAnchor, constant: 50),
            userLogoutButton.bottomAnchor.constraint(equalTo: userEmailLabel.bottomAnchor, constant: 100)
            
            
        ])
    }
    
    @objc func LogOut() {
        GIDSignIn.sharedInstance.signOut()
        self.navigationController?.pushViewController(GoogleAuthLoginVC(), animated: true)
    }
    
//    func returnUserImage() -> URL {
//        if let imageURL = GIDSignIn.sharedInstance.currentUser?.profile?.imageURL(withDimension: 100) {
//            return imageURL
//        } else {
//            return nil
//        }
//       
//    }
}
