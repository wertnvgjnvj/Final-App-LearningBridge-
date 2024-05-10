//
//  VideoCallViewController.swift
//  Final-App(LearningBridge)
//
//  Created by Sahil Aggarwal on 09/05/24.
//

import UIKit
import SwiftUI

class VideoCallViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        extractViews()
        // Do any additional setup after loading the view.
    }
    
    
    func extractViews() {
        let hostView = UIHostingController(rootView: VideoCallApp())
        hostView.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(hostView.view)
        
        let constraints = [
            hostView.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            hostView.view.heightAnchor.constraint(equalTo: view.heightAnchor),
            hostView.view.widthAnchor.constraint(equalTo: view.widthAnchor)
            
            
        
        ]

        NSLayoutConstraint.activate(constraints)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
