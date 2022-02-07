//
//  TabBarController.swift
//  SpaceX
//
//  Created by Mikita Shalima on 7.02.22.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let rocketListNav = RocketNavVC(rootViewController: RocketListVC())
        let launchListNav = LaunchNavVC(rootViewController: LaunchListVC())
        let launchpadListNav = LaunchpadNavVC(rootViewController: LaunchpadListVC())
        viewControllers = [rocketListNav, launchListNav, launchpadListNav]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.barTintColor = UIColor(named: "Queen Blue")
        tabBar.tintColor = UIColor(named: "Coral")
        tabBar.unselectedItemTintColor = UIColor(named: "Champagne")
    }
    
}
