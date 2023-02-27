//
//  SearchItemTableViewCell.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 23/02/2023.
//

import UIKit

class SearchItemTableViewCell: UITableViewCell {
    
    static let identifier = "SearchItemTableViewCell"

    lazy var imagView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "shakira")
        return imageView
    }()

    lazy var titleSongLabel: UILabel = {
        let label = UILabel()
        label.text = "As it Was"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var artistLabel: UILabel = {
        let label = UILabel()
        label.text = "Olivia rodrigo"
        label.textColor = .systemGray3
        label.font = .systemFont(ofSize: 12, weight: .thin)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var popularityButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "arrow.up.heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20))
        let customGoldColor = UIColor(red: 0.84, green: 0.69, blue: 0.18, alpha: 1.0)
        button.setImage(image, for: .normal)
        button.backgroundColor = .black
        button.tintColor = customGoldColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var popularityLabel: UILabel = {
        let label = UILabel()
        label.text = "89"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .heavy)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier  )
        
        contentView.addSubview(titleSongLabel)
        contentView.addSubview(artistLabel)
        contentView.addSubview(imagView)
        contentView.addSubview(popularityButton)
        contentView.addSubview(popularityLabel)
   
        
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
            
            titleSongLabel.leadingAnchor.constraint(equalTo: imagView.trailingAnchor, constant: 20),
            titleSongLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -10),
            titleSongLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            
            artistLabel.topAnchor.constraint(equalTo: titleSongLabel.bottomAnchor, constant: 5),
            artistLabel.leadingAnchor.constraint(equalTo: imagView.trailingAnchor,constant: 20),
            
            popularityButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            popularityButton.trailingAnchor.constraint(equalTo: popularityLabel.leadingAnchor, constant: -5),
            
            popularityLabel.centerYAnchor.constraint(equalTo: popularityButton.centerYAnchor),
            popularityLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5)
            
            
        ])
   
    }
    
    public func configure(with model: SearchModel) {
        titleSongLabel.text = model.name
        artistLabel.text = model.artist
        popularityLabel.text =  String(model.popularity)
        let localImage = "https://i.scdn.co/image/ab67616d0000b273a56268c7c8c09366e91042db"
        guard let url = URL(string: model.image)else { return }
        imagView.sd_setImage(with: url)
        
        
    }
    

}
