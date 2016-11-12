//
//  WorldTableViewController.swift
//  Overload
//
//  Created by Draveness on 11/12/16.
//  Copyright © 2016 Draveness. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Cosmos


class WorldTableViewController: UITableViewController {

    var worlds: [World] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Multiverse"
        tableView.register(WorldTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = UIColor(hex: 0xF9F9F9)
        tableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        Alamofire.request("http://10.97.194.14:8080/hack/web/World/list.do").responseJSON { response in
            print(response.result)

            if let data = response.data {
                let json = JSON(data: data)
                let lists = json["M"]["docs"].arrayValue

                self.worlds = lists.map { json in
                    World(json: json)
                }
                self.tableView.reloadData()
            }

        }

    }

    // MARK: - UITableViewDataSource

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return worlds.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WorldTableViewCell
//        let world = worlds[indexPath.row]
//        cell.worldImageView.sd_setImage(with: world.banner)

        return cell
    }

    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 310
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(SceneViewController(), animated: true)
    }
}

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
