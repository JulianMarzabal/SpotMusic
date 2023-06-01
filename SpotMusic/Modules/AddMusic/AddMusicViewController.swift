//
//  AddMusicViewController.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 26/03/2023.
//

import UIKit


class AddMusicViewController: UIViewController {
    
    var viewmodel: AddMusicViewModel
   

    init(viewmodel: AddMusicViewModel){
        self.viewmodel = viewmodel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var label:UILabel = {
        let label = UILabel()
        label.text = "Add to this playlist"
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var searchButton: UIButton = {
        let button = UIButton()
        
        let image = UIImage(systemName: "magnifyingglass")
        image?.withTintColor(.white)
        button.setImage(image, for: .normal)
        button.tintColor = .white
        
        button.setTitle("Search", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.semanticContentAttribute = .forceLeftToRight
        button.translatesAutoresizingMaskIntoConstraints = false
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: -8)
        button.addTarget(self, action: #selector(onSearchView), for: .touchUpInside)
        
        button.backgroundColor = UIColor.grayCustom
        button.layer.cornerRadius = 10.0
        
        
        
        return button
    }()
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AddMusicTableViewCell.self, forCellReuseIdentifier: AddMusicTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.grayCustom
        //tableView.tintColor = UIColor.grayCustom
        tableView.contentInsetAdjustmentBehavior = .never
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false

    
        return tableView
    }()
    lazy var headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.backgroundColor = UIColor.grayCustom
        headerLabel.text = "Suggestions"
        headerLabel.textColor = .white
        headerLabel.textAlignment = .left
        headerLabel.font = .boldSystemFont(ofSize: 16)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
       return headerLabel
    }()
    
 

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setContraints()
        bindReaction()
        viewmodel.getRecommendation()
       // viewmodel.addItemToPlaylist(playlistID: "05StVqloyG5WUukEO8vMPL", uri: "spotify:track:7lPN2DXiMsVn7XUKtOW1CS")
        
       

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewmodel.updateViewModel()
        
    }
    
    func setupUI(){
        view.backgroundColor = .black
        let homeImage = UIImage(systemName: "house")
        let homeButton = UIBarButtonItem(image: homeImage, style: .plain, target: self, action: #selector(goToHome))
        homeButton.tintColor = .systemBlue
        navigationItem.leftBarButtonItem = homeButton
        
        
        view.addSubview(label)
        view.addSubview(searchButton)
        view.addSubview(tableView)
        view.addSubview(headerLabel)
    }
    
    func setContraints() {
        NSLayoutConstraint.activate([
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchButton.topAnchor.constraint(equalTo: label.bottomAnchor,constant: 30),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchButton.heightAnchor.constraint(equalToConstant: 44),
            searchButton.widthAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5),
            headerLabel.topAnchor.constraint(equalTo: searchButton.bottomAnchor,constant: 20),
            headerLabel.heightAnchor.constraint(equalToConstant: 30),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 5),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 5),
            tableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
    }
    func bindReaction(){
        viewmodel.onSuccessfullUpdateReaction = {[weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                
            }
            
        }
    }
    @objc func onSearchView() {
        let vc = AddSearchViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc func goToHome() {
        viewmodel.delegate?.navigateToHome()
    }


}

extension AddMusicViewController: UISearchBarDelegate {
    
}


extension AddMusicViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.cellModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddMusicTableViewCell.identifier, for: indexPath) as? AddMusicTableViewCell else
        {
            return UITableViewCell()
        }
        let model = viewmodel.cellModel[indexPath.row]
        cell.configure(with: model)
        return cell
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
   
 
    
}
