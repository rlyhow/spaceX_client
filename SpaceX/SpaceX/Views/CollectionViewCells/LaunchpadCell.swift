//
//  LaunchpadCell.swift
//  SpaceX
//
//  Created by Mikita Shalima on 7.02.22.
//

import UIKit

class LaunchpadCell: UICollectionViewCell {
    
    private lazy var launchpadTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Bold", size: 24)
        label.textColor = .black
        return label
    }()
    
    private lazy var launchpadLocationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Medium", size: 17)
        label.textColor = .black
        return label
    }()
    
    private lazy var launchpadStatusView: ViewWithTwoShadows = {
        let view = ViewWithTwoShadows(frame: .zero, backgroundColor: self.backgroundColor)
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
        setupCell()
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        backgroundColor = UIColor(named: "White")
        layer.cornerRadius = 15
        layer.shadowOpacity = 0.37
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 6
        layer.shadowColor = UIColor.black.cgColor
    }
    
    private func addViews() {
        addSubview(launchpadTitleLabel)
        addSubview(launchpadLocationLabel)
        addSubview(launchpadStatusView)
        
        launchpadStatusView.addSubview(launchpadStatusLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            launchpadTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            launchpadTitleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            
            launchpadLocationLabel.leadingAnchor.constraint(equalTo: launchpadTitleLabel.leadingAnchor),
            launchpadLocationLabel.topAnchor.constraint(equalTo: launchpadTitleLabel.bottomAnchor, constant: 5),
            
            launchpadStatusView.leadingAnchor.constraint(equalTo: launchpadLocationLabel.leadingAnchor),
            launchpadStatusView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -17),
            launchpadStatusView.trailingAnchor.constraint(equalTo: launchpadStatusLabel.trailingAnchor, constant: 10),
            launchpadStatusView.heightAnchor.constraint(equalToConstant: 32),
            
            launchpadStatusLabel.centerXAnchor.constraint(equalTo: launchpadStatusView.centerXAnchor),
            launchpadStatusLabel.centerYAnchor.constraint(equalTo: launchpadStatusView.centerYAnchor),
        ])
    }
    
}
