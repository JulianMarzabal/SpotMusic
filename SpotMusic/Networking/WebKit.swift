////
////  WebKit.swift
////  SpotMusic
////
////  Created by Julian Marzabal on 19/03/2023.
////
//
//import Foundation
//import UIKit
//import WebKit
//
//class ViewController: UIViewController {
//
//    var webView: WKWebView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let webConfiguration = WKWebViewConfiguration()
//        webView = WKWebView(frame: .zero, configuration: webConfiguration)
//        webView.navigationDelegate = self
//        view.addSubview(webView)
//
//        // establece las restricciones del WebView
//        webView.translatesAutoresizingMaskIntoConstraints = false
//        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
//        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
//
//        // carga la solicitud de autorización de Spotify
//        authorization()
//    }
//
//    func authorization() {
//        var components = URLComponents(string: "https://accounts.spotify.com/authorize")
//        components?.queryItems = [
//            URLQueryItem(name: "client_id", value: "19705411f2bd4583a2538641ef7c4856"),
//            URLQueryItem(name: "response_type", value: "code"),
//            URLQueryItem(name: "redirect_uri", value: "https://a39f-2802-8010-8d27-e900-b0ca-5ed9-289b-527.sa.ngrok.io/callback/")
//        ]
//        guard let url = components?.url else { return }
//        let request = URLRequest(url: url)
//        webView.load(request)
//    }
//}
//extension ViewController: WKNavigationDelegate {
//
//    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//            // Obtener la URL actual del web view
//            guard let url = webView.url else { return }
//
//            // Analizar la URL y buscar el valor del parámetro "code"
//            guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true),
//                  let code = components.queryItems?.first(where: { $0.name == "code" })?.value else { return }
//
//            print("Código de autorización: \(code)")
//        print(components.query)
//
//            // Aquí puedes usar el código de autorización para solicitar tokens de acceso y actualización.
//            // Consulta la documentación de la API
//    }
//}
