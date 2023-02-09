//
//  PlaylistTableViewController.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 29/01/2023.
//

import UIKit



class PlaylistViewController: UIViewController {
    var viewmodel: PlaylistViewModel
    
    init(viewmodel: PlaylistViewModel){
        self.viewmodel = viewmodel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PlaylistTableViewCell.self, forCellReuseIdentifier: PlaylistTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
    
        return tableView
    }()
    lazy var imagView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "shakira")
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
  

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Playlist"
        bindReaction()
        viewmodel.getPlaylistByID()
       
     
        setupUI()
        setConstraints()

    }

    override func viewWillAppear(_ animated: Bool) {
        viewmodel.updateViewModel()
    }
    private func bindReaction(){
        viewmodel.onSuccessfullUpdateReaction = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    
    func setupUI(){
        view.addSubview(tableView)
        view.addSubview(imagView)
        view.sendSubviewToBack(imagView)
        tableView.backgroundColor = .black
        
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            
            imagView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imagView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imagView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imagView.heightAnchor.constraint(equalToConstant:200),
            //imagView.widthAnchor.constraint(equalToConstant: 200),
           // imagView.bottomAnchor.constraint(equalTo: tableView.topAnchor,constant: 60),
            
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: imagView.bottomAnchor, constant: 60)
        
        ])
    }
    
    
    
}


extension PlaylistViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodel.myPlaylistModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: PlaylistTableViewCell.identifier, for: indexPath) as? PlaylistTableViewCell else {
            return UITableViewCell()
        }
      
        let model = viewmodel.myPlaylistModel[indexPath.row]
        cell.delegate = self
        cell.configure(with: model)
        
        
       
        
        return cell
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    
}

extension PlaylistViewController: musicPlayerProtocol {
    func playmusic() {
      
    }
    
    
}
