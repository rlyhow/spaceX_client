//
//  RocketListVC.swift
//  SpaceX
//
//  Created by Mikita Shalima on 7.02.22.
//

import UIKit

class RocketListVC: UIViewController {
    
    private let networkManager = NetworkManager()
    private var dataSourceRockets: [Rocket] = []
    private var filteredDataSource: [Rocket] = []
    private let urlString = "https://api.spacexdata.com/v4/rockets"
    
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor(named: "Queen Blue")
        return collection
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.color = .white
        indicator.style = .large
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RocketCell.self, forCellWithReuseIdentifier: "RocketCell")
        
        addViews()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        perfomLoadingWithGETRequest()
    }
    
    func addViews() {
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
    func perfomLoadingWithGETRequest() {
        activityIndicator.startAnimating()
        
        networkManager.performGetRequest(urlString: urlString, completionHandler: { (data, error) in
            
            if let _error = error {
                print(_error.localizedDescription)
                return
            }
            
            guard let _data = data else {
                print("no data")
                return
            }
            
            guard let rockets = try? JSONDecoder().decode([Rocket].self, from: _data) else { return }
            
            DispatchQueue.main.async { [unowned self] in
                self.dataSourceRockets = rockets
                filteredDataSource = rockets
                collectionView.reloadData()
                activityIndicator.stopAnimating()
            }
            
        })
    }
    
}

// MARK: - UICollectionViewDataSource
extension RocketListVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: RocketCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RocketCell", for: indexPath) as! RocketCell
        
        let object = filteredDataSource[indexPath.item]
        cell.setupRocketCellContent(rocketObject: object)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RocketListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingWidth: CGFloat = 18 * 2
        let availableWidth = collectionView.frame.width - paddingWidth
        return  CGSize(width: availableWidth, height: availableWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        UIEdgeInsets(top: 30, left: 18, bottom: 30, right: 18)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        50
    }
}

//MARK: - UICollectionViewDelegate
extension RocketListVC: UICollectionViewDelegate {
    
}
