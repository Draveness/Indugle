//
//  SceneViewController.swift
//  Overload
//
//  Created by Draveness on 11/12/16.
//  Copyright © 2016 Draveness. All rights reserved.
//

import UIKit

class SceneViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        view.backgroundColor = UIColor(hex: 0xf7f7f7)

        let sceneVC = SceneCollectionViewController(collectionViewLayout: SceneFlowLayout())
        addChildViewController(sceneVC)
        view.addSubview(sceneVC.view)

        sceneVC.view.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(0)
            make.height.equalTo(174)
        }
    }
}

class SceneFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        self.itemSize = CGSize(width: 155, height: 174)
        self.minimumLineSpacing = 10
        self.minimumInteritemSpacing = 10
        self.scrollDirection = .horizontal
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return proposedContentOffset }

        var offsetAdjustment: CGFloat = CGFloat(FLT_MAX)
        let horizontalOffset = proposedContentOffset.x + 24

        let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
        let array = super.layoutAttributesForElements(in: targetRect)

        array?.forEach({ attributes in
            let itemOffset = attributes.frame.origin.x
            if abs(itemOffset - horizontalOffset) < abs(offsetAdjustment) {
                offsetAdjustment = itemOffset - horizontalOffset
            }
        })

        let resultPoint = CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)

//        let lockQueue = DispatchQueue(label: "com.test.lock.queue")
//        lockQueue.sync() {
//            let resultPoint = CGPoint(x: proposedContentOffset.x + offsetAdjustment + 25, y: proposedContentOffset.y)
//            let row = collectionView.indexPathForItem(at: resultPoint)?.row ?? 0
//
//            collectionView.indexPathsForVisibleItems.forEach { indexPath in
//                if let cell = collectionView.cellForItem(at: indexPath) as? SceneCollectionViewCell {
//                    cell.current = indexPath.row == row
//                }
//            }
//
//        }

        return resultPoint
    }

}

class SceneCollectionViewController: UICollectionViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(SceneCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        navigationController?.pushViewController(MenuCollectionViewController(), animated: true)
    }
}

class SceneCollectionViewCell: UICollectionViewCell {
    let sceneImageView = UIImageView().then {
        $0.image = #imageLiteral(resourceName: "westworld")
    }

    let sceneNameLabel = UILabel().then {
        $0.text = "西部世界"
        $0.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightUltraLight)
        $0.textAlignment = .right
    }

    let recipientCountLabel = UILabel().then {
        $0.text = "#24"
        $0.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightBold)
        $0.textAlignment = .left
    }

    let indicatorView = UIView().then {
        $0.backgroundColor = UIColor(hex: 0x45A096)
        $0.isHidden = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(sceneImageView)
        contentView.addSubview(sceneNameLabel)
        contentView.addSubview(recipientCountLabel)
        contentView.addSubview(indicatorView)

        sceneImageView.snp.makeConstraints { (make) in
            make.top.equalTo(20)
            make.height.equalTo(110)
            make.width.equalTo(155)
            make.centerX.equalToSuperview()
        }

        sceneNameLabel.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.height.equalTo(14)
            make.bottom.equalTo(-20)
        }

        recipientCountLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.height.equalTo(sceneNameLabel)
            make.bottom.equalTo(sceneNameLabel)
        }

        indicatorView.snp.makeConstraints { (make) in
            make.left.right.equalTo(sceneImageView)
            make.bottom.equalTo(sceneImageView.snp.top)
            make.height.equalTo(7)
        }

    }

    var current: Bool = false {
        didSet {
//            self.indicatorView.isHidden = !current
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
