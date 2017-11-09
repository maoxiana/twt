//
//  DetailViewController.swift
//  twt
//
//  Created by 毛线 on 2017/11/9.
//  Copyright © 2017年 毛线. All rights reserved.
//
import UIKit
class DetailViewController: UIViewController {
    var content = ""
    var webView = UIWebView(frame: UIScreen.main.bounds)
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.loadHTMLString(content, baseURL: nil)
        self.view.addSubview(self.webView)

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
