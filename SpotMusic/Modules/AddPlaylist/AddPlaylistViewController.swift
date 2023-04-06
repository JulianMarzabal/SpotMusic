//
//  addPlaylistViewController.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 19/02/2023.
//

import UIKit
import WebKit

protocol AddPlaylistViewControllerDelegate: AnyObject {
    func onNewPlaylistCreated(id:String)
}

class AddPlaylistViewController: UIViewController {
    
    var viewmodel: AddPlaylistViewModel
    weak var delegate: AddPlaylistViewControllerDelegate?
    
    init(viewmodel: AddPlaylistViewModel){
        self.viewmodel = viewmodel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
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
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
      
        textField.font = .systemFont(ofSize: 20, weight: .heavy)
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
        button.isEnabled = false
        button.addTarget(self, action: #selector(playlistCreated), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        setupConstraints()
        manageOauthToken()
       
        

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
    @objc func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            createButton.isEnabled = true
        } else {
            createButton.isEnabled = false
        }
    }
    
    
 
    
    
    
    @objc func playlistCreated() {
        guard let playlistName = nameTextfield.text else { return }
        viewmodel.createPlaylist(name: playlistName )
        // coordinator
        showPromptPlaylistCreatedView()
        
        
        
    }
    
    func manageOauthToken() {
        guard !ServiceManager.shared.isOAuth2 else {return}
        let viewModel = WebKitAuthViewModel()
        let webView = WKWebView()
        let webKitVC = WebKitViewController(viewModel: viewModel, webView: webView)
        navigationController?.pushViewController(webKitVC, animated: true)
    }
    func showPromptPlaylistCreatedView() {
        let promptPlaylistCreatedView = PromptPlaylistCreatedView(onTapped: { [weak self] in
            // Acciones a realizar cuando se toca el botón "OK" en PromptPlaylistCreatedView
            guard let newPlaylistID = self?.viewmodel.newPlaylistID else {return}
            self?.delegate?.onNewPlaylistCreated(id:newPlaylistID )
            //self?.navigationController?.popViewController(animated: true)
        })

        let popUpViewController = PopUpViewController(contentView: promptPlaylistCreatedView)
        popUpViewController.modalPresentationStyle = .overCurrentContext
        popUpViewController.modalTransitionStyle = .crossDissolve
        self.present(popUpViewController, animated: true, completion: nil)
    }
    
    func bindReaction() {
        viewmodel.onSuccessfullUpdateReaction = { [weak self] in
            DispatchQueue.main.async {
                
            }
            
        }
    }

}

    


    
    

