//
//  MusicView.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 15/02/2023.
//

import UIKit

struct FooterMusicViewModel{
    var isPlaying: Bool
    var nameSong: String
    var urlImage: String
    var handler: ()-> Void
    
}

class FooterMusicView: UIView {
    
    var handler: (()-> Void)?
    
    lazy var  label: UILabel = {
        let label = UILabel()
        label.text = "Music"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    lazy var imagView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "shakira")
      
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var progressView: UIProgressView = {
        let progress = UIProgressView()
        progress.sizeToFit()
        progress.progress = 0.5
        
        progress.progressTintColor = .systemGreen
        //progress.progressTintColor = .white
        progress.translatesAutoresizingMaskIntoConstraints = false
        return progress
    }()
    lazy var playButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 25))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action:#selector(playSong) , for: .touchUpInside)
        return button
    }()

    
    init(){
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        
        //self.backgroundColor = .init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.2)
        addSubview(label)
        addSubview(imagView)
        addSubview(progressView)
        addSubview(playButton)
        NSLayoutConstraint.activate([
            imagView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 10),
            imagView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            imagView.widthAnchor.constraint(equalToConstant: 40),
            imagView.heightAnchor.constraint(equalToConstant: 40),
            
             label.leadingAnchor.constraint(equalTo: imagView.trailingAnchor, constant: 20),
            label.centerYAnchor.constraint(equalTo: imagView.centerYAnchor),
           
            progressView.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressView.trailingAnchor.constraint(equalTo: trailingAnchor),
            progressView.bottomAnchor.constraint(equalTo: bottomAnchor),
            progressView.heightAnchor.constraint(equalToConstant: 5),
            
            playButton.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -15),
            playButton.centerYAnchor.constraint(equalTo: label.centerYAnchor),
             
            
            self.heightAnchor.constraint(equalToConstant: 80)
            
            
        
        ])
      
        

    }
    
    func stopMusic() {
        
    }
    func playmusic() {
        playSong()
        print("reaxtionn")
        
    }
    func progressMusic(progress: Float) {
        
    }
    
    @objc func playSong() {
        handler?()
        print("firsr reacti")
       
    }
    
    
    public func configure(with model: FooterMusicViewModel ) {
        //self.playlistModel = model
        label.text = model.nameSong
        guard let url = URL(string: model.urlImage) else {return}
        handler = model.handler
        playButton.tintColor = model.isPlaying ? .systemGreen : .white
     
        imagView.sd_setImage(with: url)
    }

}
