//
//  DescriptionStackView.swift
//  SpaceX
//
//  Created by Mikita Shalima on 9.02.22.
//

import UIKit

class DescriptionStackView: UIStackView {
    
    private var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "Smoky Black")
        label.font = UIFont(name: "Roboto-Bold", size: 24)
        return label
    }()
    
    private var descriptionText: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont(name: "Roboto-Medium", size: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        alignment = .leading
        spacing = 20
        addArrangedSubview(label)
        addArrangedSubview(descriptionText)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(label: String, descriptionText: String?) {
        self.label.text = label
        self.descriptionText.text = descriptionText
    }
    
}
