//
//  FilterSegmentedControl.swift
//  SpaceX
//
//  Created by Mikita Shalima on 8.02.22.
//

import UIKit

class FilterSegmentedControl: UISegmentedControl {

    init(_ titleOne: String, _ titleTwo: String, _ titleThree: String) {
        super.init(frame: .zero)
        insertSegment(withTitle: titleOne, at: 0, animated: false)
        insertSegment(withTitle: titleTwo, at: 1, animated: false)
        insertSegment(withTitle: titleThree, at: 2, animated: false)
        setupFilter()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
    private func setupFilter() {
        backgroundColor = UIColor(named: "Glaucous")
        selectedSegmentTintColor = UIColor(named: "White")
        selectedSegmentIndex = 0
    }

}
