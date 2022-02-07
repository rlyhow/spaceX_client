//
//  RocketNavVC.swift
//  SpaceX
//
//  Created by Mikita Shalima on 7.02.22.
//

import UIKit

class RocketNavVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBarItem.image = UIImage(named: "rocket")
        tabBarItem.title = "Rockets"
        tabBarItem.setTitleTextAttributes([.font: UIFont(name: "Roboto-Bold", size: 10)!], for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationBar.barTintColor = UIColor(named: "Queen Blue")
        navigationBar.tintColor = UIColor(named: "Coral")
    }

}
