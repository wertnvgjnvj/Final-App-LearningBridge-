////
////  ViewController.swift
////  VideoPlayer
////
////  Created by Sahil Aggarwal on 03/05/24.
////
//import AVKit
//import AVFoundation
//import UIKit
//
//class CustomAVPlayerViewController: AVPlayerViewController {
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        if isBeingDismissed {
//            player?.pause()
//        }
//    }
//}
//
//class VideoViewController: UIViewController {
//
//    var playerViewController: CustomAVPlayerViewController?
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
//    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        playVideo()
//    }
//
//    func playVideo() {
//        let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Tenses", ofType: "mp4")!))
//        
//        let vc = CustomAVPlayerViewController()
//        vc.player = player
//        playerViewController = vc // Retain a reference to CustomAVPlayerViewController
//        present(vc, animated: true)
//    }
//}
//
