//
//  RocketListVC.swift
//  SpaceX
//
//  Created by Mikita Shalima on 7.02.22.
//

import UIKit

class RocketListVC: UIViewController {

    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor(named: "Queen Blue")
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addViews()
    }
    
    func addViews() {
        view.addSubview(collectionView)
    }

}
