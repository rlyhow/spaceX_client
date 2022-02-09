//
//  LauchpadDetailVC.swift
//  SpaceX
//
//  Created by Mikita Shalima on 9.02.22.
//

import UIKit

class LauchpadDetailVC: UIViewController {
    
    var launchpadObject: Launchpad?
    
    var mainScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    lazy var headerBlock: LaunchpadDetailHeaderView = {
        let view = LaunchpadDetailHeaderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setupTextForHeaderView (
            name: launchpadObject?.name,
            fullName: launchpadObject?.fullName,
            status: launchpadObject?.status
        )
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        addView()
        addConstraints()
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
    
    func addView() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(headerBlock)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            headerBlock.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor),
            headerBlock.topAnchor.constraint(equalTo: mainScrollView.topAnchor),
            headerBlock.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor),
        ])
    }
    
}
