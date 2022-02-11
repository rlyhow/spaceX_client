//
//  ImageCell.swift
//  SpaceX
//
//  Created by Mikita Shalima on 11.02.22.
//

import UIKit

class ImageCell: UICollectionViewCell {
    
    lazy var rocketImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "placeholderRocket")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 7
        return imageView
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
        layer.cornerRadius = 10
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        layer.shadowRadius = 3
        layer.shadowColor = UIColor(red: 0.682, green: 0.682, blue: 0.753, alpha: 0.4).cgColor
        
        addSubviews()
        setupConstraints()
    }
    
    private func addSubviews() {
        addSubview(rocketImage)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            rocketImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            rocketImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            rocketImage.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            rocketImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
    }
    
}
