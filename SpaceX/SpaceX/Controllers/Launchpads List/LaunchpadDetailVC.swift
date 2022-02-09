//
//  LauchpadDetailVC.swift
//  SpaceX
//
//  Created by Mikita Shalima on 9.02.22.
//

import UIKit
import MapKit

class LaunchpadDetailVC: UIViewController {
    
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
    
    var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.alignment = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 40, left: 20, bottom: 40, right: 20)
        return stackView
    }()
    
    lazy var descriptionBlock: DescriptionStackView = {
        let stack = DescriptionStackView()
        stack.setup(label: "Description", descriptionText: launchpadObject?.details)
        return stack
    }()
    
    lazy var mapBlock: MapStackView = {
        let stack = MapStackView(latitude: launchpadObject?.latitude, longitude: launchpadObject?.longitude, locality: launchpadObject?.locality, labelText: "Location")
        return stack
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
        mainScrollView.addSubview(mainStackView)
        
        if let _ = launchpadObject?.details {
            mainStackView.addArrangedSubview(descriptionBlock)
        }
        
        if let _ = launchpadObject?.latitude, let _ = launchpadObject?.longitude {
            mainStackView.addArrangedSubview(mapBlock)
        }
        
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
            
            mainStackView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor),
            mainStackView.topAnchor.constraint(equalTo: headerBlock.bottomAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
        ])
    }
    
}
