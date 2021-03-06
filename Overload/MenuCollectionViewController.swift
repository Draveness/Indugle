//
//  MenuCollectionViewController.swift
//  Overload
//
//  Created by Draveness on 11/12/16.
//  Copyright © 2016 Draveness. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

private let reuseIdentifier = "Cell"

class MenuCollectionViewController: UICollectionViewController {

    convenience init() {
        self.init(collectionViewLayout: MenuFlowLayout())
    }

    var meals: [Meal] = []

    var keyword: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "菜单"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        collectionView!.register(RecipientCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView?.backgroundColor = UIColor.white
        collectionView?.contentInset = UIEdgeInsetsMake(15, 15, 15, 15)

        Alamofire.request("\(baseURL)/hack/web/Event/foodlist.do", method: .get, parameters: ["keyword": keyword], encoding:  URLEncoding.default, headers: nil).responseJSON { (response) in
            if let data = response.data {
                let json = JSON(data: data)
                let lists = json["M"]["docs"].arrayValue

                self.meals = lists.map { json in
                    Meal(json: json)
                }

                self.collectionView?.reloadData()
                print(self.meals)
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return meals.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! RecipientCollectionViewCell

        let meal = meals[indexPath.row]
        cell.imageView.sd_setImage(with: meal.icon)
        cell.nameLabel.text = meal.name
        cell.descLabel.text = meal.desc
        cell.priceLabel.text = "￥\(meal.price)"
        return cell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let meal = meals[indexPath.row]
        let detailVC = DetailViewController()
        detailVC.meal = meal
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

class MenuFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        self.itemSize = CGSize(width: 165, height: 200)
        self.minimumLineSpacing = 24
        self.minimumInteritemSpacing = 15
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class RecipientCollectionViewCell: UICollectionViewCell {
    let imageView = UIImageView().then {
        $0.image = #imageLiteral(resourceName: "eagle")
    }
    let nameLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15.0, weight: UIFontWeightBold)
        $0.text = "SEAHOOD 水货双人套餐"
    }

    let descLabel = UILabel().then {
        $0.text = "如置身于蔚蓝广袤的海洋之中"
        $0.font = UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightRegular)
        $0.textColor = UIColor.lightGray
    }

    let priceLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 13.0, weight: UIFontWeightThin)
        $0.textColor = UIColor(hex: 0x45A096)
        $0.text = "￥219"
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = UIColor.white

        contentView.addSubview(imageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(descLabel)
        contentView.addSubview(priceLabel)

        imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(125)
        }

        nameLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(12.5)
        }

        descLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameLabel)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
        }

        priceLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(nameLabel)
            make.top.equalTo(descLabel.snp.bottom).offset(5)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
