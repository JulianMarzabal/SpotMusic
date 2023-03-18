//
//  PopUpViewController.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 16/03/2023.
//

import Foundation
import UIKit

protocol ViewButtonProtocol:UIView {
    var onTapped: ()->Void { get set }
}


class PopUpViewController:UIViewController {
    var contentView: ViewButtonProtocol

    
    init(contentView: ViewButtonProtocol) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    
   
    
    private func configureUI() {
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        self.view.backgroundColor = nil
        
        NSLayoutConstraint.activate([
            contentView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -40),
            contentView.heightAnchor.constraint(equalToConstant: 200),
            contentView.widthAnchor.constraint(equalToConstant: 250)
        ])
   
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let action = contentView.onTapped
        contentView.onTapped = { [weak self] in
            self?.dismiss(animated: true)
            action()
        }
        configureUI()
    }
    
    
    
}
