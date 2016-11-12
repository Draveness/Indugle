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

        let url = URL(string: "http://www.ebookfrenzy.com/ios_book/movie/movie.mov")
        let player = AVPlayer(url: url!)
        let playerController = AVPlayerViewController()

        playerController.player = player
        self.addChildViewController(playerController)
        self.view.addSubview(playerController.view)
        playerController.view.frame = self.view.frame

        player.play()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
