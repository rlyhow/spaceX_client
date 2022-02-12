//
//  LaunchDetailVC.swift
//  SpaceX
//
//  Created by Mikita Shalima on 10.02.22.
//

import UIKit

class LaunchDetailVC: UIViewController {

    var launchObject: Launch!
    
    var mainScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    lazy var headerBlock: LaunchDetailHeaderView = {
        let view = LaunchDetailHeaderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setupView(launchObject: launchObject)
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
        stack.setup(label: "Description", descriptionText: launchObject.details)
        return stack
    }()
    
    lazy var overviewBlock: TableStackView = {
        let stack = TableStackView()
        stack.setup(label: "Overview")
        
        if let staticFireDateUTC = launchObject.staticFireDateUTC {
            stack.addInfo(labelText: "Static fire date", detailsText: staticFireDateUTC.getFormattedDate(formatFrom: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", formatTo: "MMMM d, yyyy"))
        }
        stack.addInfo(labelText: "Launch date", detailsText: launchObject.dateUTC.getFormattedDate(formatFrom: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", formatTo: "MMMM d, yyyy"))
        if let success = launchObject.success {
            stack.addInfo(labelText: "Success", detailsText: success ? "Yes" : "No")
        }
        
        return stack
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
    }
    
    func addViews() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(headerBlock)
        mainScrollView.addSubview(mainStackView)
        
        if let _ = launchObject.details {
            mainStackView.addArrangedSubview(descriptionBlock)
        }
        mainStackView.addArrangedSubview(overviewBlock)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            headerBlock.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            headerBlock.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerBlock.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            headerBlock.heightAnchor.constraint(equalTo: headerBlock.widthAnchor, multiplier: 0.4),
            
            mainStackView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor),
            mainStackView.topAnchor.constraint(equalTo: headerBlock.bottomAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
        ])
    }

}
