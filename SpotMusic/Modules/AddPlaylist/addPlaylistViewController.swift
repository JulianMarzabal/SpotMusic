//
//  addPlaylistViewController.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 19/02/2023.
//

import UIKit

class addPlaylistViewController: UIViewController {
    
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create a new playlist"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 26, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Introduce a name"
        label.textColor = .white
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var nameTextfield: UITextField = {
        let textField = UITextField()
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.gray]
        let attributedPlaceholder = NSAttributedString(string: "Enter a playlist name", attributes: attributes)
        textField.attributedPlaceholder = attributedPlaceholder
        textField.tintColor = .white
        textField.placeholder = " Enter a playlist name"
      
        textField.font = .systemFont(ofSize: 20, weight: .heavy)
        textField.autocapitalizationType = .none
        textField.textColor = .systemGreen
        textField.autocorrectionType = .no
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        
        return textField
    }()
    
    lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Create", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 22)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 9
        button.tintColor = .white
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        setupConstraints()
       
        

    }
    
    
    func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(nameLabel)
        view.addSubview(nameTextfield)
        view.addSubview(createButton)
        
        
        
        
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor,constant: 20),
            
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 40),
            
            nameTextfield.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextfield.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 20),
            
            createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createButton.topAnchor.constraint(equalTo: nameTextfield.bottomAnchor,constant: 40),
            createButton.heightAnchor.constraint(equalToConstant: 60),
            createButton.widthAnchor.constraint(equalToConstant: 120)
        ])
    }
    



}
