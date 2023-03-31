//
//  WebKitAuthViewController.swift
//  SpotMusic
//
//  Created by Julian Marzabal on 19/03/2023.
//

import Foundation
import UIKit
import WebKit

class WebKitViewController: UIViewController {
    var viewModel: WebKitAuthViewModel
    var webView: WKWebView
    
    init(viewModel: WebKitAuthViewModel, webView: WKWebView){
        self.viewModel = viewModel
        self.webView = webView
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadWebKit()
        
      
    
        
        
    }
    
    func loadWebKit() {
        if let request = viewModel.getAuthorizationToken() {
                webView.load(request)
            
            }
        
        
        
        
    }
    
        
    func setupUI(){
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.navigationDelegate = self
        view.addSubview(webView)
        
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
   
}
extension WebKitViewController: WKNavigationDelegate {
    
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
           
            guard let url = webView.url else { return }
            
            
            guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
                  let code = components.queryItems?.first(where: { $0.name == "code" })?.value else { return }
            
        
            print("Código de autorización: \(code)")
        viewModel.getAcessToken(code: code)
       // navigationController?.popViewController(animated: true)
            
            
    }
}
