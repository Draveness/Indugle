//
//  WorldViewController.swift
//  Overload
//
//  Created by Draveness on 11/12/16.
//  Copyright © 2016 Draveness. All rights reserved.
//

import UIKit
import WebKit

class WorldViewController: UIViewController {

    var url: URL

    init(url: String) {
        self.url = URL(string: url)!
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let detailButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.tintColor = UIColor.black

        let webView = WKWebView()
        webView.frame = view.frame
        webView.load(URLRequest(url: url))
        view.addSubview(webView)

        detailButton.setTitle("DetailPushButton", for: .normal)
        detailButton.setTitleColor(UIColor.red, for: .normal)
        detailButton.addTarget(self, action: #selector(detailButtonClicked), for: .touchUpInside)
        webView.addSubview(detailButton)
        detailButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 30))
        }
    }

    func detailButtonClicked(btn: UIButton) {
        print("Detail Button Touched")

//        let menuViewController = MenuTableViewController()
//        navigationController?.pushViewController(menuViewController, animated: true)
    }
}
