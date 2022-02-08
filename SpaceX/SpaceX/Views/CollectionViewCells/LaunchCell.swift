//
//  LaunchCell.swift
//  SpaceX
//
//  Created by Mikita Shalima on 8.02.22.
//

import UIKit

class LaunchCell: UICollectionViewCell {
    
    private lazy var launchNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Bold", size: 24)
        label.textColor = .black
        return label
    }()
    
    private lazy var launchDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Medium", size: 17)
        label.textColor = .black
        return label
    }()
    
    private lazy var upcomingBackgroundView: ViewWithTwoShadows = {
        let view = ViewWithTwoShadows(frame: .zero, backgroundColor: self.backgroundColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var upcomingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: "Cyan Process")
        return imageView
    }()
    
    private lazy var launchNumberBackgroundView: ViewWithTwoShadows = {
        let view = ViewWithTwoShadows(frame: .zero, backgroundColor: self.backgroundColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var launchNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Roboto-Medium", size: 17)
        label.textColor = UIColor(named: "Cyan Process")
        return label
    }()
    
    private lazy var patchBackgroundView: ViewWithTwoShadows = {
        let view = ViewWithTwoShadows(frame: .zero, backgroundColor: self.backgroundColor)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        return view
    }()
    
    private lazy var patchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
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
        addSubview(launchNameLabel)
        addSubview(launchDateLabel)
        addSubview(upcomingBackgroundView)
        addSubview(launchNumberBackgroundView)
        addSubview(patchBackgroundView)
        
        upcomingBackgroundView.addSubview(upcomingImageView)
        launchNumberBackgroundView.addSubview(launchNumberLabel)
        patchBackgroundView.addSubview(patchImageView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            
            launchNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            launchNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            launchNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: patchImageView.leadingAnchor, constant: -10),
            
            launchDateLabel.leadingAnchor.constraint(equalTo: launchNameLabel.leadingAnchor),
            launchDateLabel.topAnchor.constraint(equalTo: launchNameLabel.bottomAnchor, constant: 5),
            
            upcomingBackgroundView.leadingAnchor.constraint(equalTo: launchDateLabel.leadingAnchor),
            upcomingBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -17),
            upcomingBackgroundView.widthAnchor.constraint(equalToConstant: 32),
            upcomingBackgroundView.heightAnchor.constraint(equalToConstant: 32),
            
            upcomingImageView.leadingAnchor.constraint(equalTo: upcomingBackgroundView.leadingAnchor, constant: 3),
            upcomingImageView.trailingAnchor.constraint(equalTo: upcomingBackgroundView.trailingAnchor, constant: -3),
            upcomingImageView.topAnchor.constraint(equalTo: upcomingBackgroundView.topAnchor, constant: 3),
            upcomingImageView.bottomAnchor.constraint(equalTo: upcomingBackgroundView.bottomAnchor, constant: -3),
            
            launchNumberBackgroundView.leadingAnchor.constraint(equalTo: upcomingBackgroundView.trailingAnchor, constant: 10),
            launchNumberBackgroundView.topAnchor.constraint(equalTo: upcomingBackgroundView.topAnchor),
            launchNumberBackgroundView.bottomAnchor.constraint(equalTo: upcomingBackgroundView.bottomAnchor),
            launchNumberBackgroundView.trailingAnchor.constraint(equalTo: launchNumberLabel.trailingAnchor, constant: 10),
            
            launchNumberLabel.centerXAnchor.constraint(equalTo: launchNumberBackgroundView.centerXAnchor),
            launchNumberLabel.centerYAnchor.constraint(equalTo: launchNumberBackgroundView.centerYAnchor),
            
            patchBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            patchBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            patchBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -17),
            patchBackgroundView.widthAnchor.constraint(equalTo: patchBackgroundView.heightAnchor),
            
            patchImageView.leadingAnchor.constraint(equalTo: patchBackgroundView.leadingAnchor, constant: 9.5),
            patchImageView.trailingAnchor.constraint(equalTo: patchBackgroundView.trailingAnchor, constant: -9.5),
            patchImageView.topAnchor.constraint(equalTo: patchBackgroundView.topAnchor, constant: 15),
            patchImageView.bottomAnchor.constraint(equalTo: patchBackgroundView.bottomAnchor, constant: -15),
        ])
    }
    
    func setupLaunchCellContent(launchObject: Launch) {
        self.launchNameLabel.text = launchObject.name
        self.launchDateLabel.text = launchObject.dateUTC.getFormattedDate(formatFrom: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", formatTo: "MMMM d, yyyy")
        self.launchNumberLabel.text = "#" + String(launchObject.flightNumber)
        upcomingImageView.image  = launchObject.upcoming ? UIImage(systemName: "clock") : UIImage(systemName: "checkmark.circle")
        
        if let img = launchObject.patchImage {
            self.patchImageView.image = img
        } else {
            self.patchImageView.image = UIImage(named: "placeholderPatch")
        }
    }
    
}
