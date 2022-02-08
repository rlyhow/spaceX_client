//
//  RocketCell.swift
//  SpaceX
//
//  Created by Mikita Shalima on 8.02.22.
//

import UIKit

class RocketCell: UICollectionViewCell {
    
    private var shadowView = UIView()
    
    private lazy var rocketImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private lazy var rocketNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Bold", size: 24)
        label.textColor = UIColor(named: "Smoky Black")
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .center
        return stack
    }()
    
    private lazy var leftStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var middleStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var rightStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        return stack
    }()
    
    private lazy var firstLaunchTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "First launch"
        label.font = UIFont(name: "Roboto-Bold", size: 14)
        return label
    }()
    
    private lazy var firstLaunchLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "February 6, 2018"
        label.font = UIFont(name: "Roboto-Bold", size: 14)
        label.textColor = UIColor(named: "Slate Gray")
        return label
    }()
    
    private lazy var launchCostTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Launch cost"
        label.font = UIFont(name: "Roboto-Bold", size: 14)
        return label
    }()
    
    private lazy var launchCostLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "90000000$"
        label.font = UIFont(name: "Roboto-Bold", size: 14)
        label.textColor = UIColor(named: "Slate Gray")
        return label
    }()
    
    private lazy var successTitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Success"
        label.font = UIFont(name: "Roboto-Bold", size: 14)
        return label
    }()
    
    private lazy var successLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "100%"
        label.font = UIFont(name: "Roboto-Bold", size: 14)
        label.textColor = UIColor(named: "Slate Gray")
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        backgroundColor = UIColor(named: "White")
        layer.cornerRadius = 20
        layer.shadowOpacity = 0.37
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 6
        layer.shadowColor = UIColor.black.cgColor
        
        shadowView.translatesAutoresizingMaskIntoConstraints = false
        shadowView.clipsToBounds = true
        shadowView.layer.cornerRadius = 20
        
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(shadowView)
        
        shadowView.addSubview(rocketImage)
        shadowView.addSubview(rocketNameLabel)
        shadowView.addSubview(mainStackView)
        
        mainStackView.addArrangedSubview(leftStackView)
        mainStackView.addArrangedSubview(middleStackView)
        mainStackView.addArrangedSubview(rightStackView)
        
        leftStackView.addArrangedSubview(firstLaunchTitleLabel)
        leftStackView.addArrangedSubview(firstLaunchLabel)
        middleStackView.addArrangedSubview(launchCostTitleLabel)
        middleStackView.addArrangedSubview(launchCostLabel)
        rightStackView.addArrangedSubview(successTitleLabel)
        rightStackView.addArrangedSubview(successLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            shadowView.leadingAnchor.constraint(equalTo: leadingAnchor),
            shadowView.trailingAnchor.constraint(equalTo: trailingAnchor),
            shadowView.topAnchor.constraint(equalTo: topAnchor),
            shadowView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            rocketImage.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor),
            rocketImage.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            rocketImage.topAnchor.constraint(equalTo: shadowView.topAnchor),
            rocketImage.heightAnchor.constraint(equalTo: shadowView.heightAnchor, multiplier: 0.66),
            
            rocketNameLabel.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 20),
            rocketNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: shadowView.trailingAnchor, constant: -10),
            rocketNameLabel.topAnchor.constraint(equalTo: rocketImage.bottomAnchor, constant: 10),
            
            mainStackView.leadingAnchor.constraint(equalTo: shadowView.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: shadowView.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: rocketNameLabel.bottomAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: shadowView.bottomAnchor),
        ])
        
        rocketNameLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
}
