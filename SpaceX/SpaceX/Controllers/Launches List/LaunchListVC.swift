//
//  LaunchListVC.swift
//  SpaceX
//
//  Created by Mikita Shalima on 7.02.22.
//

import UIKit

class LaunchListVC: UIViewController {

    private let networkManager = NetworkManager()
    private var dataSourceLaunches: [Launch] = []
    private var filteredDataSource: [Launch] = []
    private let urlString = "https://api.spacexdata.com/v5/launches"
    private let imageCache = NSCache<NSString, UIImage>()
    
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor(named: "Queen Blue")
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LaunchCell.self, forCellWithReuseIdentifier: "LaunchCell")
        
        addViews()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        perfomLoadingWithGETRequest()
    }
    
    func addViews() {
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func perfomLoadingWithGETRequest() {
        networkManager.performGetRequest(urlString: urlString, completionHandler: { (data, error) in
            
            if let _error = error {
                print(_error.localizedDescription)
                return
            }
            
            guard let _data = data else {
                print("no data")
                return
            }
            
            guard let launches = try? JSONDecoder().decode([Launch].self, from: _data) else { return }
            
            DispatchQueue.main.async { [unowned self] in
                dataSourceLaunches = launches
                filteredDataSource = launches
                collectionView.reloadData()
            }
            
        })
    }
    
    func downloadImageForIndexPath(_ indexPath: IndexPath) {
        let launch = filteredDataSource[indexPath.item]
        guard let urlString = launch.links.patch.small else {
            return
        }
        
        if let image = imageCache.object(forKey: urlString as NSString) {
            filteredDataSource[indexPath.item].patchImage = image
            return
        }
        
        networkManager.loadImage(forUrl: urlString) { [unowned self] image in
            DispatchQueue.main.async {
                filteredDataSource[indexPath.item].patchImage = image
                imageCache.setObject(image!, forKey: urlString as NSString)
                collectionView.reloadItems(at: [indexPath])
            }
        }
        
    }

}

// MARK: - UICollectionViewDataSource
extension LaunchListVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: LaunchCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LaunchCell", for: indexPath) as! LaunchCell
        
        if filteredDataSource[indexPath.item].patchImage == nil {
            downloadImageForIndexPath(indexPath)
        }
        
        let object = filteredDataSource[indexPath.item]
        cell.setupLaunchCellContent(launchObject: object)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LaunchListVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingWidth: CGFloat = 18 * 2
        let availableWidth = collectionView.frame.width - paddingWidth
        return  CGSize(width: availableWidth, height: availableWidth / 2.6)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 30, left: 18, bottom: 30, right: 18)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        30
    }
}

//MARK: - UICollectionViewDelegate
extension LaunchListVC: UICollectionViewDelegate {
    
}
