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
    private let imageCache = NSCache<NSString, UIImage>()
    
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
    
    private lazy var alertSort: UIAlertController = {
        let alert = UIAlertController(title: nil, message: "Choose your option", preferredStyle: .actionSheet)
        alert.view.tintColor = UIColor(named: "Coral")
        
        let action1 = UIAlertAction(title: "First launch", style: .default, handler: { [unowned self] _ in
            filteredDataSource.sort {
                $0.firstFlight < $1.firstFlight
            }
            collectionView.reloadData()
        })
        let action2 = UIAlertAction(title: "Launch cost", style: .default, handler: { [unowned self] _ in
            filteredDataSource.sort {
                $0.costPerLaunch > $1.costPerLaunch
            }
            collectionView.reloadData()
        })
        let action3 = UIAlertAction(title: "Success rate", style: .default, handler: { [unowned self] _ in
            filteredDataSource.sort {
                $0.successRatePct > $1.successRatePct
            }
            collectionView.reloadData()
        })
        let action4 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        action4.setValue(UIColor.red, forKey: "titleTextColor")
        
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        alert.addAction(action4)
        
        return alert
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(RocketCell.self, forCellWithReuseIdentifier: "RocketCell")
        
        addViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(sortCollection))
        tabBarController?.tabBar.isHidden = false
        navigationController?.navigationBar.isHidden = false
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
    
    @objc func sortCollection() {
        self.present(alertSort, animated: true, completion: nil)
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
    
    func downloadImageForIndexPath(_ indexPath: IndexPath) {
        let rocket = filteredDataSource[indexPath.item]
        guard let urlString = rocket.flickrImages.first else {
            return
        }
        
        if let image = imageCache.object(forKey: urlString as NSString) {
            filteredDataSource[indexPath.item].rocketImage = image
            return
        }
        
        networkManager.loadImage(forUrl: urlString) { [unowned self] image in
            DispatchQueue.main.async {
                filteredDataSource[indexPath.item].rocketImage = image
                imageCache.setObject(image!, forKey: urlString as NSString)
                collectionView.reloadItems(at: [indexPath])
            }
        }
        
    }
    
}

// MARK: - UICollectionViewDataSource
extension RocketListVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: RocketCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RocketCell", for: indexPath) as! RocketCell
        
        if filteredDataSource[indexPath.item].rocketImage == nil {
            downloadImageForIndexPath(indexPath)
        }
        
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let rocketDetailVC = RocketDetailVC()
        rocketDetailVC.rocketObject = filteredDataSource[indexPath.item]
        navigationController?.pushViewController(rocketDetailVC, animated: true)
    }
}
