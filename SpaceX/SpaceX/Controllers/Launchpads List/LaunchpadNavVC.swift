//
//  LaunchpadNavVC.swift
//  SpaceX
//
//  Created by Mikita Shalima on 7.02.22.
//

import UIKit

class LaunchpadNavVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarItem.image = UIImage(named: "lego")
        tabBarItem.title = "Lauchpads"
        tabBarItem.setTitleTextAttributes([.font: UIFont(name: "Roboto-Bold", size: 10)!], for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationBar.barTintColor = UIColor(named: "Queen Blue")
        navigationBar.tintColor = UIColor(named: "Coral")
    }

}
