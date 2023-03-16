//
//  MusicCollectionViewCell.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 23/01/2023.
//

import UIKit
import SDWebImage

class MusicCollectionViewCell: UICollectionViewCell {
    static let identifier = "MusicCollectionViewCell"
    
    var playlistModel: PlaylistsHomeModel?
    
    lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.text = "Cumbia"
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var genreImageView: UIImageView = {
        let imageView = UIImageView()
        //let image = UIImage(systemName: "music.quarternote.3")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 2
        
        
        //imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        //contentView.backgroundColor = .blue
        contentView.addSubview(genreLabel)
        contentView.addSubview(genreImageView)
        contentView.layer.cornerRadius = 10
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            genreLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor,constant: 10),
            genreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10),
            
            
            genreImageView.topAnchor.constraint(equalTo: genreLabel.bottomAnchor, constant: 10),
            genreImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5),
            genreImageView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            genreImageView.heightAnchor.constraint(equalToConstant: 60),
            genreImageView.widthAnchor.constraint(equalToConstant: 60),
            
        
        ])
    }
    public func configure(with model: PlaylistsHomeModel) {
        genreLabel.text = model.name ?? "N/A"
        //print("el url \(model.images)")
        guard let url = URL(string: model.images?.first?.url ?? "nil")else { return }
        genreImageView.sd_setImage(with: url)
        genreImageView.layer.cornerRadius = 20
    }
   
    
    
}
