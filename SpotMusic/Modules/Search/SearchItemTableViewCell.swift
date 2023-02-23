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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier  )
        
        contentView.addSubview(titleSongLabel)
        contentView.addSubview(imagView)
   
        
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
            
            titleSongLabel.leadingAnchor.constraint(equalTo: imagView.trailingAnchor, constant: 10),
            titleSongLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleSongLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -40),
            
            
        ])
        
    }

}
