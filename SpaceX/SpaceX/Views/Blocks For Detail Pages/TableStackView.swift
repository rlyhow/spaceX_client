//
//  TableStackView.swift
//  SpaceX
//
//  Created by Mikita Shalima on 9.02.22.
//

import UIKit

class TableStackView: UIStackView {

    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "Smoky Black")
        label.font = UIFont(name: "Roboto-Bold", size: 24)
        return label
    }()
    
    private var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 20
        stack.distribution = .fillProportionally
        return stack
    }()
    
    lazy private var stackWithTitles: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        stack.distribution = .fillProportionally
        return stack
    }()
    
    lazy private var stackWithInfo: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 15
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        axis = .vertical
        alignment = .leading
        spacing = 20
        
        addArrangedSubview(titleLabel)
        addArrangedSubview(mainStack)
        
        mainStack.addArrangedSubview(stackWithTitles)
        mainStack.addArrangedSubview(stackWithInfo)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(label: String) {
        self.titleLabel.text = label
    }
    
    func addInfo(labelText: String, detailsText: String?) {
        
        guard let _ = detailsText else {
            return
        }
        
        let label = UILabel()
        label.textColor = UIColor(named: "Smoky Black")
        label.font = UIFont(name: "Roboto-Bold", size: 14)
        label.text = labelText
        
        let details = UILabel()
        details.textColor = UIColor(named: "Slate Gray")
        details.font = UIFont(name: "Roboto-Bold", size: 14)
        details.lineBreakMode = .byCharWrapping
        details.text = detailsText
        
        stackWithTitles.addArrangedSubview(label)
        stackWithInfo.addArrangedSubview(details)
    }

}
