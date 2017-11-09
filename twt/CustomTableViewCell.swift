//
//  CustomTableViewCell.swift
//  twt
//
//  Created by 毛线 on 2017/11/9.
//  Copyright © 2017年 毛线. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
class CustomTableViewCell: UITableViewCell {
    var subjectLabel = UILabel()
    var picView = UIImageView()
    var backLabel = UILabel()
    
    let picinstead = "https://open.twtstudio.com/imgcache/315c39cb920aa399263efcc7a057f84e.jpg"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backLabel.backgroundColor = .white
        contentView.addSubview(backLabel)
        backLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(contentView).offset(8)
            make.bottom.equalTo(contentView).offset(-8)
            make.left.equalTo(contentView).offset(5)
            make.right.equalTo(contentView).offset(-5)
        }
        subjectLabel.textAlignment = .left
        subjectLabel.numberOfLines = 0
        subjectLabel.font = UIFont.italicSystemFont(ofSize:20)
        backLabel.addSubview(subjectLabel)
        subjectLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(backLabel)
            make.top.equalTo(backLabel).offset(20)
        }

        backLabel.addSubview(picView)
        picView.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(backLabel)
            make.left.equalTo(subjectLabel.snp.right)
            make.right.equalTo(backLabel).offset(-5)
            make.height.equalTo(backLabel).multipliedBy(0.8)
            make.width.equalTo(backLabel).multipliedBy(0.25)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initCell(subject: String, pic: String) {
        subjectLabel.text = subject
        picView.sd_setImage(with: URL(string: pic))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
