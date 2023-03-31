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
    lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.tintColor = .white
        searchBar.barStyle = .black
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.backgroundColor = UIColor.grayCustom
        searchBar.searchTextField.tintColor = .white
        // Haz transparente el fondo de la UISearchBar
        searchBar.backgroundImage = UIImage()
        
        searchBar.searchTextField.textColor = .white
        // Personaliza el color de fondo del campo de búsqueda
        searchBar.searchTextField.backgroundColor = UIColor.grayCustom

        searchBar.searchTextField.tintColor = .white

        searchBar.searchTextField.layer.cornerRadius = 10
        searchBar.searchTextField.layer.masksToBounds = true
        searchBar.searchTextField.layer.borderColor = UIColor.clear.cgColor
        searchBar.searchTextField.layer.borderWidth = 0
        if let searchIcon = searchBar.searchTextField.leftView as? UIImageView {
            searchIcon.image = searchIcon.image?.withRenderingMode(.alwaysTemplate)
            searchIcon.tintColor = .white
        }
    
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Buscar canciones"
        return searchBar
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
        viewmodel.getRecommendation()

    }
    
    func setupUI(){
        view.backgroundColor = .black
        view.addSubview(label)
        view.addSubview(searchBar)
        view.addSubview(tableView)
        view.addSubview(headerLabel)
    }
    
    func setContraints() {
        NSLayoutConstraint.activate([
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.topAnchor.constraint(equalTo: label.bottomAnchor,constant: 30),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5),
            headerLabel.topAnchor.constraint(equalTo: searchBar.bottomAnchor,constant: 20),
            headerLabel.heightAnchor.constraint(equalToConstant: 30),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 5),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 5),
            tableView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
    }
    


}

extension AddMusicViewController: UISearchBarDelegate {
    
}


extension AddMusicViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddMusicTableViewCell.identifier, for: indexPath) as? AddMusicTableViewCell else
        {
            return UITableViewCell()
        }
        return cell
       
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
   
   
    
    
    
    
    
    
    
}
