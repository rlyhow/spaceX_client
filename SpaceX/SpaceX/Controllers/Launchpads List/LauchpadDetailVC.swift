//
//  LauchpadDetailVC.swift
//  SpaceX
//
//  Created by Mikita Shalima on 9.02.22.
//

import UIKit

class LauchpadDetailVC: UIViewController {

    var launchpadObject: Launchpad?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        
        navigationItem.title = launchpadObject?.name
        navigationController?.navigationBar.titleTextAttributes = [
            .font: UIFont(name: "Roboto-Bold", size: 24)!,
            .foregroundColor: UIColor(named: "White")!
        ]
    }

}
