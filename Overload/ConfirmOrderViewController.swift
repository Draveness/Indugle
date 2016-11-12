
//
//  ConfirmOrderViewController.swift
//  Overload
//
//  Created by Draveness on 11/12/16.
//  Copyright © 2016 Draveness. All rights reserved.
//

import UIKit
import MBProgressHUD

class ConfirmOrderViewController: UIViewController {

    // MARK: - List

    let circleView = UIView().then {
        $0.backgroundColor = UIColor.red.lighter()
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 4.0
    }

    let listView = UIView().then {
        $0.backgroundColor = UIColor.white
    }

    let separaterLine = UIView().then {
        $0.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
    }

    let worldLabel = UILabel().then {
        $0.text = "射雕英雄传"
        $0.textColor = UIColor.lightGray
        $0.font = UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightLight)
    }

    let foodNameLabel = UILabel().then {
        $0.text = "二十四桥明月夜"
        $0.textColor = UIColor.black
        $0.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightBold)
    }

    let priceLabel = UILabel().then {
        $0.text = "219.9 元 x 1"
        $0.textColor = UIColor.lightGray
        $0.font = UIFont.systemFont(ofSize: 16.0, weight: UIFontWeightRegular)
    }

    // MAKR: - Function

    let functionView = UIView().then {
        $0.backgroundColor = UIColor.white
    }

    let checkoutButton = UIButton().then {
        $0.backgroundColor = UIColor(hex: 0xEE584A)
        $0.setTitleColor(UIColor.white, for: .normal)
        $0.setTitle("去支付", for: .normal)
        $0.layer.cornerRadius = 7
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightBold)
        $0.clipsToBounds = true
    }

    let inTotalLabel = UILabel().then {
        $0.text = "合计：219.9 元"
        $0.textColor = UIColor(hex: 0xEE584A)
        $0.font = UIFont.systemFont(ofSize: 14.0, weight: UIFontWeightLight)
    }

    let borderLineView = UIView().then {
        $0.backgroundColor = UIColor.lightGray
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "确认订单"
        view.backgroundColor = UIColor(hex: 0xf7f7f7)

        view.addSubview(listView)
        listView.addSubview(circleView)
        listView.addSubview(worldLabel)
        listView.addSubview(separaterLine)
        listView.addSubview(foodNameLabel)
        listView.addSubview(priceLabel)

        view.addSubview(functionView)
        functionView.addSubview(checkoutButton)
        functionView.addSubview(borderLineView)
        functionView.addSubview(inTotalLabel)

        circleView.snp.makeConstraints { (make) in
            make.size.equalTo(8.0)
            make.right.equalTo(worldLabel.snp.left).offset(-5)
            make.centerY.equalTo(worldLabel)
        }

        listView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(120)
        }

        worldLabel.snp.makeConstraints { (make) in
            make.left.equalTo(30)
            make.top.equalTo(20)
        }

        separaterLine.snp.makeConstraints { (make) in
            make.left.equalTo(18)
            make.right.equalTo(-18)
            make.height.equalTo(0.5)
            make.top.equalTo(worldLabel.snp.bottom).offset(16)
        }

        foodNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(separaterLine.snp.bottom).offset(16)
            make.left.equalTo(worldLabel)
        }

        priceLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(foodNameLabel)
            make.right.equalTo(separaterLine)
        }

        borderLineView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(0.5)
        }

        functionView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(60)
        }

        checkoutButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 85, height: 40))
            make.right.equalTo(-20)
        }

        inTotalLabel.snp.makeConstraints { (make) in
            make.right.equalTo(checkoutButton.snp.left).offset(-7)
            make.centerY.equalToSuperview()
        }

        checkoutButton.addTarget(self, action: #selector(checkout), for: .touchUpInside)
    }

    func checkout() {
        let hud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
        hud.label.text = "正在支付"
        hud.mode = .indeterminate
        hud.hide(animated: true, afterDelay: 2.0)
        hud.backgroundView.color = UIColor(white: 0, alpha: 0.5)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let hud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
            hud.backgroundView.color = UIColor(white: 0, alpha: 0.5)
            hud.label.text = "支付成功"
            hud.mode = .customView
            hud.customView = UIImageView(image: #imageLiteral(resourceName: "check-mark"))
            hud.hide(animated: true, afterDelay: 1.0)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            _ = self.navigationController?.popToRootViewController(animated: true)
        }

    }

}
