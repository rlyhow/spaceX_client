//
//  RocketDetailVC.swift
//  SpaceX
//
//  Created by Mikita Shalima on 10.02.22.
//

import UIKit

class RocketDetailVC: UIViewController {
    
    var rocketObject: Rocket?
    
    var mainScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    lazy var headerBlock: RocketDetailHeaderImageView = {
        let imageView = RocketDetailHeaderImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setup(image: rocketObject?.rocketImage, rocketName: rocketObject?.name)
        return imageView
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        addViews()
        addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.isHidden = true
    }
    
    func addViews() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(headerBlock)
        mainScrollView.addSubview(mainStackView)
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
            headerBlock.heightAnchor.constraint(equalTo: headerBlock.widthAnchor),
            
            mainStackView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor),
            mainStackView.topAnchor.constraint(equalTo: headerBlock.bottomAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
        ])
    }
    
}
