//
//  LaunchpadDetailHeaderView.swift
//  SpaceX
//
//  Created by Mikita Shalima on 9.02.22.
//

import UIKit

class LaunchpadDetailHeaderView: UIView {

    private var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.font = UIFont(name: "Roboto-Bold", size: 24)
        return label
    }()
    
    private var fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "Roboto-Medium", size: 17)
        return label
    }()
    
    private lazy var launchpadStatusBackgroundView: ViewWithTwoShadows = {
        let view = ViewWithTwoShadows(frame: .zero, backgroundColor: UIColor(named: "White"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var launchpadStatusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Medium", size: 17)
        label.textColor = UIColor(named: "Cyan Process")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addViews() {
        addSubview(nameLabel)
        addSubview(fullNameLabel)
        addSubview(launchpadStatusBackgroundView)
        launchpadStatusBackgroundView.addSubview(launchpadStatusLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20),
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 30),
            
            fullNameLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            fullNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20),
            fullNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            
            launchpadStatusBackgroundView.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            launchpadStatusBackgroundView.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 20),
            launchpadStatusBackgroundView.trailingAnchor.constraint(equalTo: launchpadStatusLabel.trailingAnchor, constant: 10),
            launchpadStatusBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            launchpadStatusBackgroundView.heightAnchor.constraint(equalToConstant: 32),
            
            launchpadStatusLabel.centerXAnchor.constraint(equalTo: launchpadStatusBackgroundView.centerXAnchor),
            launchpadStatusLabel.centerYAnchor.constraint(equalTo: launchpadStatusBackgroundView.centerYAnchor),
        ])
    }
    
    func setupTextForHeaderView(name: String?, fullName: String?, status: String?) {
        self.nameLabel.text = name
        self.fullNameLabel.text = fullName
        self.launchpadStatusLabel.text = status
    }

}
