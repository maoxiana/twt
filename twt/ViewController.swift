//
//  ViewController.swift
//  twt
//
//  Created by 毛线 on 2017/11/8.
//  Copyright © 2017年 毛线. All rights reserved.
//

import UIKit
import Alamofire
import SDWebImage
import MJRefresh
var dataArray: [DataModel] = []
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var dataArray:[DataModel] = []
    var tableView: UITableView?
    
    let header = MJRefreshNormalHeader()
    override func viewDidLoad() {
        super.viewDidLoad()
        // 加载数据
        loadDataSourse()
        //加载TableView
        self.tableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
        self.tableView?.register(CustomTableViewCell.self, forCellReuseIdentifier: "newsCell")
        self.tableView?.backgroundColor = UIColor(red: 0xef/255, green: 0xef/255, blue: 0xf4/255, alpha: 1)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.separatorStyle = .none
        self.view.addSubview(tableView!)
        let headLabel = UILabel()
        headLabel.textColor = UIColor.gray
        headLabel.numberOfLines = 0
        headLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        headLabel.text = "  天外天新闻"
        headLabel.font = UIFont.italicSystemFont(ofSize:15)
        self.tableView?.tableHeaderView = headLabel
        headLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(tableView!).offset(5)
            make.height.equalTo(50)
        }
        header.setRefreshingTarget(self, refreshingAction: #selector(ViewController.headerRefresh))
        self.tableView!.mj_header = header
        
    }
    // 下拉刷新
    @objc func headerRefresh(){
        dataArray = []
        loadDataSourse()
        self.tableView!.reloadData()
        //结束刷新
        self.tableView!.mj_header.endRefreshing()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height/5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? CustomTableViewCell
        if cell == nil{
            tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "newsCell")
            cell = (tableView.dequeueReusableCell(withIdentifier: "newsCell") as? CustomTableViewCell)!
        }
        cell?.initCell(subject: dataArray[indexPath.row].subject, pic: dataArray[indexPath.row].pic)
        cell?.backgroundColor = UIColor(red: 0xef/255, green: 0xef/255, blue: 0xf4/255, alpha: 1)
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = DetailViewController()
        vc.content = dataArray[indexPath.row].content
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    func loadDataSourse(){
        var model: DataModel?
        Alamofire.request("https://open.twtstudio.com/api/v1/news/5/page/1",method: .get)
            .responseJSON { response in
                guard let json = response.result.value else { return }
                let dict = json as! Dictionary<String,AnyObject>
                let data = dict["data"] as! [Dictionary<String,AnyObject>]
                for j in 0..<data.count{
                    let index = data[j]["index"] as! String
                    let subject = data[j]["subject"] as! String
                    let pic = data[j]["pic"] as! String
                    Alamofire.request( "https://open.twtstudio.com/api/v1/news/\(index)", method: .get)
                        .responseJSON{ response in
                            guard let json = response.result.value else { return }
                            let news = json as! Dictionary<String,AnyObject>
                            let newsData = news["data"] as! Dictionary<String,AnyObject>
                            let newscontent = newsData["content"] as! String
                            model = DataModel(subject: subject, pic: pic, content: newscontent)
                            self.dataArray.append(model!)
                            self.tableView?.reloadData()
                    }
                }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
