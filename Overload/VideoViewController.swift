//
//  VideoViewController.swift
//  Overload
//
//  Created by Draveness on 11/12/16.
//  Copyright © 2016 Draveness. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class VideoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let localURL = Bundle.main.url(forResource: "WeChatSight6", withExtension: "mp4")

        let url = URL(string: "http://www.ebookfrenzy.com/ios_book/movie/movie.mov")
        let player = AVPlayer(url: localURL!)
        let playerController = AVPlayerViewController()

        playerController.player = player
        self.addChildViewController(playerController)
        self.view.addSubview(playerController.view)
        playerController.view.frame = self.view.frame

        player.play()

    }
}
