//
//  WebViewController.swift
//  Overload
//
//  Created by Draveness on 11/12/16.
//  Copyright © 2016 Draveness. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    var url: URL

    init(url: String) {
        self.url = URL(string: url)!
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    override func viewDidLoad() {
        super.viewDidLoad()

        let webView = UIWebView()
        webView.frame = view.frame
        webView.loadRequest(URLRequest(url: url))
        view.addSubview(webView)
    }

}
