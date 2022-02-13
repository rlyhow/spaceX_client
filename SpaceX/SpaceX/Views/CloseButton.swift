//
//  CloseButton.swift
//  SpaceX
//
//  Created by Mikita Shalima on 13.02.22.
//

import UIKit

class CloseButton: UIButton {
    
    private var xMarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "xmark.circle")
        imageView.tintColor = UIColor(named: "Coral")
        //imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
        addViews()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if self.point(inside: point, with: event) {
            return self
        }
        return super.hitTest(point, with: event)
    }
    
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func addViews() {
        addSubview(xMarkImageView)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            xMarkImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            xMarkImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            xMarkImageView.topAnchor.constraint(equalTo: topAnchor),
            xMarkImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.5 : 1
        }
    }
    
}
