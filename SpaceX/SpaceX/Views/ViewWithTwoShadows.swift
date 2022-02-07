//
//  ViewWithTwoShadows.swift
//  SpaceX
//
//  Created by Mikita Shalima on 7.02.22.
//

import UIKit

class ViewWithTwoShadows: UIView {

    private let secondView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init(frame: CGRect, backgroundColor: UIColor?) {
        super.init(frame: frame)
        
        setupView()
        addView()
        addConstraints()
        secondView.backgroundColor = backgroundColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        layer.shadowOffset = CGSize(width: 1.5, height: 1.5)
        layer.shadowColor = UIColor(red: 0.682, green: 0.682, blue: 0.753, alpha: 1).cgColor
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 3
        
        secondView.layer.shadowOffset = CGSize(width: -1, height: -1)
        secondView.layer.shadowColor = UIColor.white.cgColor
        secondView.layer.shadowOpacity = 1
        secondView.layer.shadowRadius = 3
    }
    
    private func addView() {
        addSubview(secondView)
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            secondView.leadingAnchor.constraint(equalTo: leadingAnchor),
            secondView.trailingAnchor.constraint(equalTo: trailingAnchor),
            secondView.topAnchor.constraint(equalTo: topAnchor),
            secondView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    override func layoutSubviews() {
        secondView.layer.cornerRadius = layer.cornerRadius
    }

}
