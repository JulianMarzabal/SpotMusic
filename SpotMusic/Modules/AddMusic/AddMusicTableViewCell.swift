//
//  AddMusicTableViewCell.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 30/03/2023.
//

import Foundation
import UIKit

struct AddMusicTableViewModel{
    var isPlaying: Bool
    var nameSong: String
    var uri: String
    var playlistID: String
    var image: String
    var handler: ()-> Void
  
}
class AddMusicTableViewCell: UITableViewCell {

    static let identifier = "AddMusicTableViewCell"
    var isPlaying:Bool = false
    var previewUrl:URL?
    var viewmodel: AddMusicViewModel?
   
    var handler: (()-> Void)?
 
   
 
    
    lazy var imagView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "shakira")
        imageView.layer.cornerRadius = 4
        imageView.clipsToBounds = true
        return imageView
    }()
    lazy var button: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "plus.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action:#selector(pressButton) , for: .touchUpInside)
        button.layer.cornerRadius = 4
        button.clipsToBounds = true
        return button
    }()
    lazy var titleSongLabel: UILabel = {
        let label = UILabel()
        label.text = "prueba"
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
            button.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            
        ])
    }
    @objc private func pressButton() {
        handler?()
        
        print("handler press")
        
    }
    
    public func configure(with model: AddMusicTableViewModel) {
        titleSongLabel.text = model.nameSong
        handler = model.handler
        guard let url = URL(string: model.image) else {return}
        imagView.sd_setImage(with: url)
        button.tintColor = model.isPlaying ? .systemGreen : .white
    }
 
 
    
   

}
