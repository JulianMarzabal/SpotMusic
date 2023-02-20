//
//  PlaylistTableViewController.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 29/01/2023.
//

import UIKit
import AVFAudio
import SDWebImage
var audioMusic: AVAudioPlayer?



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
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var footerMusic = FooterMusicView()
  

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Playlist"
        bindReaction()
        viewmodel.getPlaylistByID()
        setupUI()
        setConstraints()
       
        //imagView.sd_setImage(with: viewmodel.urlImage)
        
       

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
        viewmodel.onImageChange = { [weak self] imageURL in
            DispatchQueue.main.async {
                self?.imagView.sd_setImage(with: .init(string: imageURL))
            }
        }
        viewmodel.onplayingMusic = { [weak self]  in
            
            self?.footerMusic.playmusic()
        }
        
        viewmodel.onStopMusic = { [weak self]  in
            
            self?.footerMusic.stopMusic()
        }
        
        viewmodel.onProgressMusic = { [weak self] progress in
            self?.footerMusic.progressMusic(progress: progress)
        }
        
        
    }
  

    
    func setupUI(){
        view.addSubview(tableView)
        view.addSubview(imagView)
        view.addSubview(footerMusic)
        
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
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: imagView.bottomAnchor, constant: 60),
            
            
            
            footerMusic.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerMusic.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -18),
            footerMusic.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerMusic.heightAnchor.constraint(equalToConstant: 80)
        
        
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
      
        let model = viewmodel.cellModel[indexPath.row]
        
       
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


