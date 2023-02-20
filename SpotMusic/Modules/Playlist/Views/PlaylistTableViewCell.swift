//
//  PlaylistTableViewCell.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 29/01/2023.
//

import UIKit
import AVFoundation

struct PlaylistTableViewModel{
    var isPlaying: Bool
    var nameSong: String
    var urlImage: String
    var handler: ()-> Void
    
}



class PlaylistTableViewCell: UITableViewCell {

    static let identifier = "PlaylistTableViewCell"
    var playlistModel: myPlaylistModel?
    var isplaying: Bool = false
    var previewURL:URL?
    var handler: (()-> Void)?
 
   
 
    
    lazy var imagView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "shakira")
        return imageView
    }()
    lazy var button: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action:#selector(pressButton) , for: .touchUpInside)
        return button
    }()
    lazy var titleSongLabel: UILabel = {
        let label = UILabel()
        label.text = playlistModel?.name
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier  )
        
        contentView.addSubview(titleSongLabel)
        contentView.addSubview(imagView)
        contentView.addSubview(button)
        
        contentView.backgroundColor = .black
        setContraints()
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setContraints() {
        NSLayoutConstraint.activate([
            imagView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imagView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10),
            imagView.topAnchor.constraint(lessThanOrEqualTo: contentView.topAnchor, constant: 5),
            imagView.widthAnchor.constraint(equalToConstant: 50),
            imagView.heightAnchor.constraint(equalToConstant: 50),
            //imagView.heightAnchor.constraint(equalToConstant: 50),
            
            titleSongLabel.leadingAnchor.constraint(equalTo: imagView.trailingAnchor, constant: 5),
            titleSongLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleSongLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            
            //button.leadingAnchor.constraint(equalTo: titleSongLabel.trailingAnchor,constant: -10),
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            
        ])
    }
    @objc private func pressButton() {
        handler?()
     
        
        

   
    }
 
 
    
    public func configure(with model: PlaylistTableViewModel ) {
        //self.playlistModel = model
        titleSongLabel.text = model.nameSong
        guard let url = URL(string: model.urlImage) else {return}
        handler = model.handler
        button.tintColor = model.isPlaying ? .systemGreen : .white
     
        imagView.sd_setImage(with: url)
    }

}
