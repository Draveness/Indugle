//
//  WorldTableViewCell.swift
//  Overload
//
//  Created by Draveness on 11/12/16.
//  Copyright © 2016 Draveness. All rights reserved.
//

import UIKit
import CoreImage
import Cosmos

class WorldTableViewCell: UITableViewCell {

    let worldImageView = UIImageView().then {
        $0.image = #imageLiteral(resourceName: "eagle")
    }

    let averagePriceLabel = UILabel().then {
        $0.text = "￥20.1"
        $0.textColor = UIColor.black
        $0.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightBold)
    }

    let worldNameLabel = UILabel().then {
        $0.text = "射雕英雄传 · 限时优惠 · 主题餐具"
        $0.textColor = UIColor.black
        $0.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightUltraLight)
    }

    let cosmosView = StarView().then {
        $0.settings.starMargin = 1
        $0.settings.starSize = 13
    }

    let commentsCountLabel = UILabel().then {
        $0.text = "132 评价"
        $0.font = UIFont.systemFont(ofSize: 11, weight: UIFontWeightUltraLight)
        $0.textColor = UIColor.black
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none

        addSubview(worldImageView)
        addSubview(worldNameLabel)
        addSubview(averagePriceLabel)
        addSubview(cosmosView)
        addSubview(commentsCountLabel)

        worldImageView.snp.makeConstraints { make in
            make.left.top.equalTo(25)
            make.right.equalTo(-25)
            make.height.equalTo(210)
        }

        averagePriceLabel.snp.makeConstraints { make in
            make.left.equalTo(worldImageView)
            make.height.equalTo(19)
            make.top.equalTo(worldImageView.snp.bottom).offset(17)
        }

        worldNameLabel.snp.makeConstraints { make in
            make.lastBaseline.equalTo(averagePriceLabel)
            make.left.equalTo(averagePriceLabel.snp.right).offset(20)
            make.height.equalTo(averagePriceLabel)
        }

        cosmosView.snp.makeConstraints { make in
            make.left.equalTo(worldImageView)
            make.top.equalTo(averagePriceLabel.snp.bottom).offset(7)
        }

        commentsCountLabel.snp.makeConstraints { make in
            make.left.equalTo(cosmosView.snp.right).offset(7)
            make.centerY.equalTo(cosmosView)
        }

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
