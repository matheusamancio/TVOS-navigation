//
//  PlayerViewController.swift
//  theVideoApp
//
//  Created by Matheus Amancio Seixeiro on 5/4/16.
//  Copyright © 2016 Matheus Amancio Seixeiro. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class PlayerViewController: AVPlayerViewController, AVPlayerViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func playVideo() {
        
        player = AVPlayer(URL: NSURL(string: "http://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4")!)
        player?.play()
    }
    
}