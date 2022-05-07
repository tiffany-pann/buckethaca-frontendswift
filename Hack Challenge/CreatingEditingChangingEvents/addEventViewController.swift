//
//  addEventViewController.swift
//  Hack Challenge
//
//  Created by Tiffany Pan on 5/2/22.
//

import UIKit

class addEventViewController: UIViewController, UINavigationControllerDelegate {
    
    let allCategories: [String] = ["Academic", "Indoors", "Libaries", "Outdoors", "Clubs", "Sports"]

    
    let lilac = UIColor(red: 93/255, green: 89/255, blue: 94/255, alpha: 0.2)
    let sage: UIColor = UIColor(red: 205/255, green: 224/255, blue: 201/255, alpha: 0.2)
    
    var contrastView: UIView = {
        let contrast = UIView()
        contrast.backgroundColor = UIColor(red: 224/255, green: 236/255, blue: 222/255, alpha: 0.2)
        contrast.frame = CGRect(x: 0, y: 30, width: 390, height: 800)
        contrast.layer.cornerRadius = 40
        contrast.layer.shadowColor = UIColor.systemGray2.cgColor
        contrast.layer.shadowOpacity = 1
        contrast.layer.shadowOffset = CGSize(width: 10, height: 10)
        return contrast
    }()
    
    var gradientLine: UIView = {
        let gradientLine = UIView(frame: CGRect(x: 0, y: 0, width: 400, height: 10))

        let gradient = CAGradientLayer()
        gradient.frame = gradientLine.bounds
        gradient.colors = [UIColor.systemGray3.cgColor, UIColor.white.cgColor]
        gradientLine.layer.insertSublayer(gradient, at: 0)
        
        return gradientLine
    }()
    
    
    
    var addEventLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Your Event"
        label.font = UIFont(name: "Rockwell-Italic", size: 30)
        label.layer.shadowColor = UIColor.mintGreenAccent().cgColor
        label.layer.shadowOpacity = 1
        label.layer.shadowOffset = CGSize(width: 3, height: 3)
        return label
        
    }()
    
    var eventNameBox: UIView = {
        let box = UIView()
        box.backgroundColor = UIColor.sageGreenBackground()
        box.layer.cornerRadius = 15
        return box
    }()
    
    var eventNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Event Name"
        label.font = UIFont(name: "Montserrat-Light", size: 10)
        return label
    }()
    
    var eventNameInput: UITextField = {
        let input = UITextField()
        input.font = UIFont(name: "Montserrat-Medium", size: 16)
        return input
    }()
    
    var eventDateBox: UIView = {
        let box = UIView()
        box.backgroundColor = UIColor.sageGreenBackground()
        box.layer.cornerRadius = 15
        return box
    }()
    
    var eventDateLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Event Date"
        label.font = UIFont(name: "Montserrat-Light", size: 10)
        return label
    }()
    
    var eventLocationBox: UIView = {
        let box = UIView()
        box.backgroundColor = UIColor.sageGreenBackground()
        box.layer.cornerRadius = 15
        return box
    }()
    
    var eventLocationLabel: UILabel = {
        let label = UILabel()
        label.text = "Event Location"
        label.font = UIFont(name: "Montserrat-Light", size: 10)
        return label
    }()
    
    var eventLocationInput: UITextField = {
        let input = UITextField()
        input.font = UIFont(name: "Montserrat-Medium", size: 16)
        return input
    }()
    
    // check viewDidLoad for DatePicker settings
    var eventDateInput: UITextField = UITextField()
    
    var eventDescriptionBox: UIView = {
        let box = UIView()
        box.backgroundColor = .sageGreenBackground()
        box.layer.cornerRadius = 15
        return box
    }()
    
    var eventDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Event Description"
        label.font = UIFont(name: "Montserrat-Light", size: 10)
        return label
    }()
    
    var eventDescriptionInput: UITextView = {
        let input = UITextView()
        input.font = UIFont(name: "Montserrat-Medium", size: 16)
        input.backgroundColor = .clear
        return input
    }()
    
    var postEvent: UIButton = {
        // find out how to use a cooler button here
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 260, height: 50)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.mintGreenAccent()
        button.setTitle("Post Event", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(post), for: .touchUpInside)
        return button
    }()
    
    let cellPadding: CGFloat = 15
    lazy var filtersView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 20
        flowLayout.sectionInset = UIEdgeInsets(top: cellPadding, left: cellPadding, bottom: cellPadding, right: cellPadding)
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(FiltersCollectionViewCell.self, forCellWithReuseIdentifier: FiltersCollectionViewCell.id)
        collectionView.dataSource = self
//        collectionView.allowsMultipleSelection = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    let input = UIDatePicker()
    

    var imageView: UIImageView = UIImageView()

    var showImagePickerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Attach Photo", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(displayImagePickerButtonTapped), for: .touchUpInside)
        button.backgroundColor = UIColor.sageGreenBackground()
        button.layer.cornerRadius = 10
        return button
    }()
    var selectedCategory: String?
    
    var eventHostNameBox: UIView = {
        let box = UIView()
        box.backgroundColor = .sageGreenBackground()
        box.layer.cornerRadius = 15
        return box
    }()
    
    var eventHostNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Host Name"
        label.font = UIFont(name: "Montserrat-Light", size: 10)
        return label
    }()
    
    var eventHostNameInput: UITextView = {
        let input = UITextView()
        input.font = UIFont(name: "Montserrat-Medium", size: 16)
        input.backgroundColor = .clear
        return input
    }()
    
    override func viewDidLoad() {

        
        view.backgroundColor = .white
        
        input.datePickerMode = .dateAndTime
        input.addTarget(self, action: #selector(dateChanged), for: UIControl.Event.valueChanged)
        input.frame.size = CGSize(width: 0, height: 300)
        input.preferredDatePickerStyle = .wheels
        input.locale = Locale.init(identifier: "en_us")
        
        eventDateInput.inputView = input
        // initializing it with today's date
        eventDateInput.text = formatDate(date: Date())
        
        [gradientLine, addEventLabel, eventNameBox, eventDateBox, eventHostNameBox, eventLocationBox, eventDescriptionBox,eventNameLabel, eventNameInput,eventHostNameLabel,  eventDateLabel, eventDescriptionLabel,eventDateInput, eventLocationLabel ,eventDescriptionInput, eventLocationInput,eventDescriptionInput, eventHostNameInput, gradientLine, filtersView, postEvent, showImagePickerButton, ].forEach { subView in
            view.addSubview(subView)
            subView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        NSLayoutConstraint.activate([
            gradientLine.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            gradientLine.heightAnchor.constraint(equalToConstant: 40),
            gradientLine.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            gradientLine.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),

//            contrastView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            contrastView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
//            contrastView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
//            contrastView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            addEventLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -10),
            addEventLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 115),
            addEventLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
        ])
        // trying SnapKit...
        let padding: CGFloat = 40
        
        filtersView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(83)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
        
        eventNameBox.snp.makeConstraints { make in
            make.top.equalTo(filtersView.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
            make.height.equalTo(60)
        }
        eventNameLabel.snp.makeConstraints { make in
            make.top.equalTo(eventNameBox.snp.top)
            make.leading.equalTo(eventNameBox.snp.leading).offset(20)
            make.bottom.equalTo(eventNameBox.snp.top).offset(30)
            make.trailing.equalTo(eventNameBox.snp.trailing)
        }
        eventNameInput.snp.makeConstraints { make in
            make.top.equalTo(gradientLine.snp.bottom).offset(45)
            make.leading.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().offset(-60)
            make.height.equalTo(30)
        }
        
        eventDateBox.snp.makeConstraints { make in
            make.top.equalTo(eventNameBox.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(padding)
            make.trailing.equalToSuperview().offset(-padding)
            make.height.equalTo(60)
        }
        eventDateLabel.snp.makeConstraints { make in
            make.top.equalTo(eventDateBox.snp.top)
            make.leading.equalTo(eventDateBox.snp.leading).offset(20)
            make.bottom.equalTo(eventDateBox.snp.top).offset(30)
            make.trailing.equalTo(eventDateBox.snp.trailing)
        }
        eventDateInput.snp.makeConstraints { make in
            make.top.equalTo(eventNameBox.snp.bottom).offset(45)
            make.leading.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().offset(-60)
            make.height.equalTo(30)
        }
        
        eventLocationBox.snp.makeConstraints { make in
            make.top.equalTo(eventDateBox.snp.bottom).offset(20)
            make.leading.equalTo(eventDateBox)
            make.trailing.equalTo(eventDateBox)
            make.height.equalTo(60)
        }
        
        eventLocationLabel.snp.makeConstraints { make in
            make.top.equalTo(eventLocationBox.snp.top)
            make.leading.equalTo(eventLocationBox.snp.leading).offset(20)
            make.bottom.equalTo(eventLocationBox.snp.top).offset(30)
            make.trailing.equalTo(eventLocationBox.snp.trailing)
        }
        
        eventLocationInput.snp.makeConstraints { make in
            make.top.equalTo(eventDateBox.snp.bottom).offset(45)
            make.leading.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().offset(-60)
            make.height.equalTo(30)
        }
        
        eventDescriptionBox.snp.makeConstraints { make in
            make.top.equalTo(eventLocationBox.snp.bottom).offset(20)
            make.leading.equalTo(eventLocationBox)
            make.trailing.equalTo(eventLocationBox)
            make.height.equalTo(190)
        }
        
        eventDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(eventDescriptionBox.snp.top)
            make.leading.equalTo(eventDescriptionBox.snp.leading).offset(20)
            make.bottom.equalTo(eventDescriptionBox.snp.top).offset(30)
            make.trailing.equalTo(eventDescriptionBox.snp.trailing)
        }
        
        eventDescriptionInput.snp.makeConstraints { make in
            make.top.equalTo(eventLocationBox.snp.bottom).offset(45)
            make.leading.equalToSuperview().offset(55)
            make.trailing.equalToSuperview().offset(-60)
            make.height.equalTo(150)
        }
        
        eventHostNameBox.snp.makeConstraints{ make in
            make.top.equalTo(eventDescriptionBox.snp.bottom).offset(20)
            make.leading.equalTo(eventDescriptionBox)
            make.trailing.equalTo(eventDescriptionBox)
            make.height.equalTo(50)
        }
        
        eventHostNameLabel.snp.makeConstraints { make in
            make.top.equalTo(eventHostNameBox.snp.top)
            make.leading.equalTo(eventHostNameBox.snp.leading).offset(20)
            make.bottom.equalTo(eventHostNameBox.snp.top).offset(30)
            make.trailing.equalTo(eventHostNameBox.snp.trailing)
        }
        
        eventHostNameInput.snp.makeConstraints { make in
            make.top.equalTo(eventDescriptionBox.snp.bottom).offset(35)
            make.leading.equalToSuperview().offset(55)
            make.trailing.equalToSuperview().offset(-60)
            make.height.equalTo(150)
        }
        
        showImagePickerButton.snp.makeConstraints { make in
            make.top.equalTo(eventHostNameBox.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(120)
            make.trailing.equalToSuperview().offset(-120)
            make.height.equalTo(50)
        }
        
        postEvent.snp.makeConstraints { make in
            make.top.equalTo(showImagePickerButton.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(60)
            make.trailing.equalToSuperview().offset(-60)
            make.height.equalTo(50)
        }
        
        
        
        
        
    }
    
    @objc func dateChanged(input: UIDatePicker) {
        eventDateInput.text = formatDate(date: input.date)
    }
    
    // formats date into a string
    func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd yyyy                h mm a"
        return formatter.string(from: date)
    }
    
    @objc func post() {
    // make Post network call here to post an event
        if let name = eventNameInput.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           let date = eventDateInput.text?.trimmingCharacters(in: .whitespacesAndNewlines) ,
           let hostName = eventHostNameInput.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           let location = eventLocationInput.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           let description = eventDescriptionInput.text?.trimmingCharacters(in: .whitespacesAndNewlines),
           let image = imageView.image?.jpegData(compressionQuality: 1)?.base64EncodedString(),
           let category = selectedCategory,
            name != "", date != "", location != "", description != "" {
           // TODO: how to pass back the Categories based on what cells are selected
               //networking Post call
            // TODO: fix post request ?
            NetworkManager.postEvent(title: name, hostName: hostName, date: convertStringtoUnix(dateInput: date), location: location, description: description, categories: category, image: "data:image/png;base64,\(image)") { event in
            }
        }
        
        self.dismiss(animated: true, completion: nil)
    
    }
    
    
    
    @objc func displayImagePickerButtonTapped(_ sender: UIButton) {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        self.present(myPickerController, animated: true, completion: nil)
    }
    
    
    
}

extension UIToolbar {

func ToolbarPiker(mySelect : Selector) -> UIToolbar {

    let toolBar = UIToolbar()

    toolBar.barStyle = UIBarStyle.default
    toolBar.isTranslucent = true
    toolBar.tintColor = UIColor.black
    toolBar.sizeToFit()

    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: mySelect)
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)

    toolBar.setItems([ spaceButton, doneButton], animated: false)
    toolBar.isUserInteractionEnabled = true

    return toolBar
}

}



extension addEventViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FiltersCollectionViewCell.id, for: indexPath) as! FiltersCollectionViewCell
        
        cell.configure(category: allCategories[indexPath.row])

        return cell
        
        }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // store the category that is selected in a Global variable selectedCategory
        self.selectedCategory = allCategories[indexPath.item]

    }
}


extension addEventViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
            picker.dismiss(animated: true, completion: nil)
          }
        
    }
}
