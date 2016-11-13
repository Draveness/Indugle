//
//  SceneViewController.swift
//  Overload
//
//  Created by Draveness on 11/12/16.
//  Copyright © 2016 Draveness. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import SwiftyJSON

class SceneViewController: UIViewController, WKScriptMessageHandler, WKNavigationDelegate {

    var world: World!
    var scenes: [Scene] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = world.name

        let config = WKWebViewConfiguration()
        config.userContentController.add(self, name: "handleClick")
        let webView = WKWebView(frame: view.frame, configuration: config)
        webView.navigationDelegate = self
        webView.load(URLRequest(url: URL(string: "\(baseURL)/hack/artworld.html#worldid=\(world.id)")!))

        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Menu", style: .plain, target: self, action: #selector(pushMenuViewController))

        view.backgroundColor = UIColor(hex: 0xf7f7f7)

        let sceneVC = SceneCollectionViewController(collectionViewLayout: SceneFlowLayout())
        sceneVC.webView = webView
        addChildViewController(sceneVC)

        view.addSubview(webView)
        view.addSubview(sceneVC.view)

        webView.snp.makeConstraints { (make) in
            make.top.equalTo(view)
            make.left.right.bottom.equalToSuperview()
        }
        sceneVC.view.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(0)
            make.height.equalTo(120)
        }

        Alamofire.request("\(baseURL)/hack/web/Scene/list.do", method: .get, parameters: ["world_id": world.id], encoding: URLEncoding.queryString, headers: nil).responseJSON { response in
//            Alamofire.request("\(baseURL)/hack/web/Scene/list.do?data={\"cond\":{\"world_id\":2}}").responseJSON { response in

            if let data = response.data {
                let json = JSON(data: data)
                let lists = json["M"]["docs"].arrayValue

                self.scenes = lists.map { json in
                    Scene(json: json)
                }

                print(self.scenes)
                sceneVC.scenes = self.scenes
                sceneVC.collectionView?.reloadData()
            }
        }
    }


    func pushMenuViewController() {
        navigationController?.pushViewController(MenuCollectionViewController(), animated: true)
//        let eventVC = EventViewController()
//        let event = scenes.first?.events.first
//        eventVC.eventId = event
//        navigationController?.pushViewController(eventVC, animated: true)
    }

    // MARK: WKScriptMessageHandler

    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print(message.body)
        if let eventId = message.body as? Int {
            print(eventId)
            let eventVC = EventViewController()
//            let event = scenes.first?.events.first

            let events: [Event] = scenes.flatMap {
                $0.events
            }

            events.forEach({ (event) in
                if event.id == eventId {
                    eventVC.event = event
                    navigationController?.pushViewController(eventVC, animated: true)
                }
            })

        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        print(error)
    }

    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("commit")
    }

}

class SceneFlowLayout: UICollectionViewFlowLayout {
    override init() {
        super.init()
        self.itemSize = CGSize(width: 125, height: 120)
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
        let horizontalOffset = proposedContentOffset.x + 12

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
    weak var webView: WKWebView!
    var scenes: [Scene] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor(hex: 0x000000).withAlphaComponent(0.7)
        collectionView?.register(SceneCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return scenes.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SceneCollectionViewCell
        let scene = scenes[indexPath.row]
        cell.sceneImageView.sd_setImage(with: scene.thumbnail)
        cell.sceneNameLabel.text = scene.title
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let scene = scenes[indexPath.row]
        webView.evaluateJavaScript("Module.flyToScene(\(scene.id))", completionHandler: { result, error in
            print("\(result) \(error)")
        })
    }
}

class SceneCollectionViewCell: UICollectionViewCell {
    let sceneImageView = UIImageView().then {
        $0.image = #imageLiteral(resourceName: "westworld")
        $0.alpha = 0.7
    }

    let sceneNameLabel = UILabel().then {
        $0.text = "西部世界"
        $0.font = UIFont.systemFont(ofSize: 12.0, weight: UIFontWeightUltraLight)
        $0.textAlignment = .center
        $0.textColor = UIColor.white
    }

    let indicatorView = UIView().then {
        $0.backgroundColor = UIColor(hex: 0x45A096)
        $0.isHidden = true
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(sceneImageView)
        contentView.addSubview(sceneNameLabel)
        contentView.addSubview(indicatorView)

        sceneImageView.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.height.equalTo(80)
            make.width.equalTo(125)
            make.centerX.equalToSuperview()
        }

        sceneNameLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(14)
            make.top.equalTo(sceneImageView.snp.bottom).offset(5)
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
