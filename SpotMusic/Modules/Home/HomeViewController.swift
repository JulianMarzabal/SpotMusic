//
//  ViewController.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 22/01/2023.
//

import UIKit


class HomeViewController: UIViewController {
    private var viewModel: HomeViewModel
    private var searchResultViewController: SearchResultsViewController
    
    
    
    
    init(viewModel: HomeViewModel, searchResultViewController: SearchResultsViewController){
        self.viewModel = viewModel
        self.searchResultViewController = searchResultViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private lazy  var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: searchResultViewController)
    
        search.searchBar.placeholder = "Listen your favourite music"
        search.searchBar.inputViewController?.definesPresentationContext = true
        //search.searchBar.backgroundColor = .white
        search.searchBar.tintColor = .white
        search.searchBar.barStyle = .black
        search.searchBar.searchTextField.textColor = .white
        search.searchBar.sizeToFit()
        search.resignFirstResponder()
        search.definesPresentationContext = true
        
        
        return search
    }()
    
    private lazy var  collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: 180, height: 100)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .black
        collection.tintColor = .black
        collection.translatesAutoresizingMaskIntoConstraints = false
        //collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
       
        return collection
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.title
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        bindReaction()
        viewModel.configureObservers()
        setupUI()
        setupConstraints()
        viewModel.updateViewModel()
        
    
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.backBarButtonItem = nil
      
        viewModel.updateViewModel()
    }
    private func bindReaction(){
        viewModel.onSuccessfullUpdateReaction = { [weak self] in
            DispatchQueue.main.async {
                print("on dispatch")
                self?.collectionView.reloadData()
            }
        }
    }

   
    
    private func setupUI() {
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action:#selector(addPlaylist))
        self.navigationItem.rightBarButtonItem?.tintColor = .white
        
        
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationItem.title = viewModel.navigationtitle
        self.navigationItem.titleView?.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.isTranslucent = false
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor : UIColor.white
        ]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        view.addSubview(collectionView)
        view.addSubview(titleLabel)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MusicCollectionViewCell.self, forCellWithReuseIdentifier: MusicCollectionViewCell.identifier)
        
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
     
        
    }
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        ])
    }
    
    @objc private func addPlaylist() {
        viewModel.delegate?.toAddPlaylistView()
        
    }
        
    
    

}
extension HomeViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {}
    
}
extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text?.lowercased().replacingOccurrences(of: " ", with: "%20") else {
            return
        }
        searchResultViewController.viewModel.text = text
   
    }
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicCollectionViewCell.identifier, for: indexPath) as! MusicCollectionViewCell
        let colors = [UIColor.systemRed, UIColor.systemBlue, UIColor.systemGreen, UIColor.systemYellow, UIColor.systemPink]
        let model = viewModel.playlistHomeModel[indexPath.row]
        cell.backgroundColor = colors[indexPath.item % colors.count]
        cell.configure(with: model)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.playlistHomeModel.count
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectPlaylistBy(index: indexPath.row)
     
    }
    
}
