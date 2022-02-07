//
//  LaunchNavVC.swift
//  SpaceX
//
//  Created by Mikita Shalima on 7.02.22.
//

import UIKit

class LaunchNavVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarItem.image = UIImage(named: "adjustment")
        tabBarItem.title = "Launches"
        tabBarItem.setTitleTextAttributes([.font: UIFont(name: "Roboto-Bold", size: 10)!], for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationBar.barTintColor = UIColor(named: "Queen Blue")
        navigationBar.tintColor = UIColor(named: "Coral")
    }

}
