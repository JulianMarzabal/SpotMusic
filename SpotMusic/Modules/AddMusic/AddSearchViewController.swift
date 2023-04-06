//
//  AddSearchViewController.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 03/04/2023.
//
import UIKit

class AddSearchViewController: UIViewController {
    let searchResultViewController: SearchResultsViewController = .init(viewModel: .init())
    
    lazy var searchController: UISearchController = {
        let search = UISearchController(searchResultsController: searchResultViewController)
    
        search.searchBar.placeholder = "Listen your favourite music"
        search.searchBar.inputViewController?.definesPresentationContext = true
        search.searchBar.tintColor = .white
        search.searchBar.barStyle = .black
        search.searchBar.searchTextField.textColor = .white
        search.searchBar.sizeToFit()
        search.definesPresentationContext = true
        
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemPink
        
        // Configure search bar
        self.navigationItem.searchController = searchController
        self.navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
}

extension AddSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Execute search here
        print(searchText)
        searchResultViewController.viewModel.text = searchText
    }
}
