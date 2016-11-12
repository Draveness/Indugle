//
//  DetailViewController.swift
//  Overload
//
//  Created by Draveness on 11/12/16.
//  Copyright © 2016 Draveness. All rights reserved.
//

import UIKit
import DynamicColor

class DetailViewController: UIViewController {

    let scrollView = UIScrollView()
    let contentView = UIView()

    let descView = UIView().then {
        $0.backgroundColor = UIColor.white
    }

    let itemImageView = UIImageView().then {
        $0.image = #imageLiteral(resourceName: "beggar")
    }
    let nameLabel = UILabel().then {
        $0.text = "用美丽和爱意装点你的午后 Moon 幕恩餐厅悠闲下午茶"
        $0.numberOfLines = 0
        $0.textColor = UIColor.black
        $0.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
    }

    let priceLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 23.0, weight: UIFontWeightThin)
        $0.textColor = UIColor(hex: 0x45A096)
        $0.text = "￥219"
    }

    let detailView = UIView().then {
        $0.backgroundColor = UIColor.white
    }

    let interestingPromptLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBold)
        $0.text = "亮点"
        $0.textColor = UIColor.darkGray
    }

    let lineView = UIView().then {
        $0.backgroundColor = UIColor.lightGray
        $0.layer.cornerRadius = 1.5
        $0.clipsToBounds = true
    }

    let pointsLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 16, weight: UIFontWeightThin)
        $0.text = "· 4 折 Eleme 独享 填满主厨爱意\n· 进口食材 米其林大厨烹制\n· 极尽奢华 畅想极佳外卖体验"
        $0.textColor = UIColor.lightGray.darkened()
        $0.numberOfLines = 0
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false
        title = "叫花鸡"

        view.backgroundColor = UIColor(hex: 0xf7f7f7)

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(descView)
        descView.addSubview(itemImageView)
        descView.addSubview(nameLabel)
        descView.addSubview(priceLabel)

        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.height.equalTo(view).multipliedBy(2)
            make.width.equalToSuperview()
        }

        descView.snp.makeConstraints { (make) in
            make.height.equalTo(420)
            make.top.left.right.equalToSuperview()
        }

        itemImageView.snp.makeConstraints { (make) in
            make.height.equalTo(282)
            make.top.left.right.equalToSuperview()
        }

        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(itemImageView.snp.bottom).offset(27)
            make.left.equalTo(21)
            make.height.equalTo(45)
            make.right.equalTo(-21)
        }

        priceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(18)
            make.left.equalTo(nameLabel)
            make.height.equalTo(23)
        }

        contentView.addSubview(detailView)
        detailView.addSubview(interestingPromptLabel)
        detailView.addSubview(lineView)
        detailView.addSubview(pointsLabel)

        detailView.snp.makeConstraints { (make) in
            make.top.equalTo(descView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalToSuperview()
        }

        interestingPromptLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(24)
        }

        lineView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(interestingPromptLabel.snp.bottom).offset(9)
            make.height.equalTo(3)
            make.width.equalTo(interestingPromptLabel)
        }

        pointsLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.top.equalTo(lineView.snp.bottom).offset(10)
        }
    }

    func popViewController(btn: UIButton) {
        _ = navigationController?.popViewController(animated: true)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
