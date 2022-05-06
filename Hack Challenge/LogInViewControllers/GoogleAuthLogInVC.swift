//
//  GoogleAuthLogInVC.swift
//  Hack Challenge
//
//  Created by Tiffany Pan on 5/4/22.
//


import UIKit
import GoogleSignIn
import Firebase

class GoogleAuthLoginVC: ViewController {
    
    private let label = UILabel()
    
    let signInButton = GIDSignInButton()
    
    override func viewDidLoad() {
        
        
        view.backgroundColor = .white
        
        signInButton.addTarget(self, action: #selector(signIn), for: .touchUpInside)
        signInButton.style = .wide
        label.text = "Welcome, first time with Buckethaca? 🤗"
        label.font = UIFont(name: "Montserrat-Medium", size: 16)
        
        view.addSubview(label)
        view.addSubview(signInButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        signInButton.snp.makeConstraints { make in
            make.centerX.equalTo(label)
            make.top.equalTo(label.snp.bottom).offset(30)
        }
    }
    
    @objc func signIn() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        let signInConfig = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            if let error = error {
                print(error.localizedDescription)
            }
            // TODO: make POST request to backend
           //  user?.profile.
            self.navigationController?.pushViewController(TabViewController(), animated: true)
            if let userToken = user?.authentication.idToken {
                NetworkManager.sendToken(token: userToken) { User in
                    print(User)
                }
            }
            
        }

    }
    
}
