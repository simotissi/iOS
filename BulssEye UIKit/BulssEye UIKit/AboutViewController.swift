//
//  AboutViewController.swift
//  BulssEye UIKit
//
//  Created by Simone Tissi on 17/03/2020.
//  Copyright © 2020 Simone Tissi. All rights reserved.
//

import UIKit
import WebKit

class AboutViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = URL(string: "https://www.linkedin.com/in/simone-tissi/") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    
    @IBAction func close(){
        dismiss(animated: true, completion: nil)
    }
}
