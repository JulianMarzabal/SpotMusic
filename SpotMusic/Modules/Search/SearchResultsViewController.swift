//
//  SearchResultsViewController.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 24/01/2023.
//

import UIKit

class SearchResultsViewController: UIViewController {
    
    public var viewModel: SearchResultViewModel
    
    init(viewModel:SearchResultViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SearchItemTableViewCell.self, forCellReuseIdentifier: SearchItemTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .black
        tableView.translatesAutoresizingMaskIntoConstraints = false

    
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        view.addSubview(tableView)
        setupContraints()
        viewModel.searchItemResult()
        bindReaction()

       
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateViewModel()
    }
    
    func setupContraints() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func bindReaction(){
        viewModel.onSuccessfullUpdateReaction = {[weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
            
            
        }
    }
    


}

extension SearchResultsViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:SearchItemTableViewCell.identifier ,for: indexPath) as? SearchItemTableViewCell else {
            return UITableViewCell()
        }
        let model = viewModel.searchModel[indexPath.row]
        cell.configure(with: model)
        return cell
        
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.searchModel.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.displayDescriptionSong()
        print("cambiando")
    }
    
    
    
    
    
}
