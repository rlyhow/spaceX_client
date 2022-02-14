//
//  RocketDetailHeaderImageView.swift
//  SpaceX
//
//  Created by Mikita Shalima on 10.02.22.
//

import UIKit

class RocketDetailHeaderImageView: UIImageView {
    
    private let rocketNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "White")
        label.font = UIFont(name: "Roboto-Bold", size: 48)
        label.lineBreakMode = .byCharWrapping
        return label
    }()
    
    private let gradientLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.locations = [0.5, 1]
        gradient.colors = [ UIColor.clear.cgColor, UIColor.black.cgColor ]
        return gradient
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
        layer.addSublayer(gradientLayer)
        addSubview(rocketNameLabel)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            rocketNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            rocketNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
            rocketNameLabel.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -20),
        ])
    }
    
    func setup(image: UIImage?, rocketName: String?) {
        self.image = image
        self.contentMode = .scaleAspectFill
        self.rocketNameLabel.text = rocketName
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
          
        gradientLayer.frame = frame
    }
    
}
