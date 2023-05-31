
import UIKit
import WebKit
import StoreKit

class WebViewControler: UIViewController, WKNavigationDelegate, WKUIDelegate {

    var webPage: WKWebView!
    var urlString: String? = nil
    let loader = UIActivityIndicatorView()
    let protectionSpace = URLProtectionSpace(host: "example.com", port: 0, protocol: "http", realm: nil, authenticationMethod: NSURLAuthenticationMethodHTTPBasic)
    var isShowNav = false
    let configuration = WKWebViewConfiguration()
   
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            UIApplication.shared.isStatusBarHidden = true
        }
        let credential = URLCredentialStorage.shared.defaultCredential(for: protectionSpace)

              let userContentController = WKUserContentController()
              let script = "document.getElementById('username').value = '\(credential?.user ?? "")';document.getElementById('password').value = '\(credential?.password ?? "")';"
              let userScript = WKUserScript(source: script, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
              userContentController.addUserScript(userScript)

              let configuration = WKWebViewConfiguration()
              configuration.userContentController = userContentController
    }
    
    @objc func onWebB() {
        webPage.goBack()

    }
    
    @objc func onWebForward() {
         webPage.goForward()
     }
    
  
    func start() {
      
        webPage = WKWebView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: isShowNav ? view.frame.size.height - 60 : view.frame.size.height), configuration: configuration)
    
        view.addSubview(webPage)
        webPage.navigationDelegate = self
        if isShowNav {
            let navView = UIView()
            view.addSubview(navView)
            navView.translatesAutoresizingMaskIntoConstraints = false
            navView.topAnchor.constraint(equalTo: webPage.bottomAnchor).isActive = true
            navView.leadingAnchor.constraint(equalTo: webPage.leadingAnchor).isActive = true
            navView.trailingAnchor.constraint(equalTo: webPage.trailingAnchor).isActive = true
            navView.heightAnchor.constraint(equalToConstant: 60).isActive = true
            navView.backgroundColor = .black
            let backButton = UIButton(type: .system)
            
            backButton.setTitle("back", for: .normal)
            backButton.addTarget(self, action: #selector(onWebB), for: .touchUpInside)
            navView.addSubview(backButton)
            
            // Add constraints for the back button
            backButton.translatesAutoresizingMaskIntoConstraints = false
            backButton.leadingAnchor.constraint(equalTo: navView.leadingAnchor, constant: 20).isActive = true
            backButton.topAnchor.constraint(equalTo: navView.topAnchor, constant: 10).isActive = true
            backButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
            backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
            
            let goButton = UIButton(type: .system)
            
            goButton.setTitle("forward", for: .normal)
            goButton.addTarget(self, action: #selector(onWebForward), for: .touchUpInside)
            navView.addSubview(goButton)
            
            // Add constraints for the back button
            goButton.translatesAutoresizingMaskIntoConstraints = false
            goButton.trailingAnchor.constraint(equalTo: navView.trailingAnchor, constant: -20).isActive = true
            goButton.topAnchor.constraint(equalTo: navView.topAnchor, constant: 10).isActive = true
            goButton.widthAnchor.constraint(equalToConstant: 60).isActive = true
            goButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        }
           
        
        let url = URL(string: urlString!)!
        let request = URLRequest(url: url)
        webPage.load(request)
        
        loader.style = .large
              loader.center = view.center
              view.addSubview(loader)
              loader.startAnimating()
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
         loader.startAnimating()
     }

    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loader.stopAnimating()
       
    }
    
    func showRat(){
        if #available(iOS 14, *){
            if let scene = UIApplication.shared.connectedScenes.first as?
                UIWindowScene  {
                SKStoreReviewController.requestReview(in: scene)
            }
        } else {
            SKStoreReviewController.requestReview()
        }
    }


}


extension String {
    func localized() -> String {
        NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}
