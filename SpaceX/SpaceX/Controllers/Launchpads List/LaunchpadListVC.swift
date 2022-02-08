//
//  LaunchpadListVC.swift
//  SpaceX
//
//  Created by Mikita Shalima on 7.02.22.
//

import UIKit

class LaunchpadListVC: UIViewController {
    
    private let networkManager = NetworkManager()
    private var dataSourceLaunchpads: [Launchpad] = []
    private var filteredDataSource: [Launchpad] = []
    private let urlString = "https://api.spacexdata.com/v4/launchpads"
    
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
        
        let action1 = UIAlertAction(title: "Title", style: .default, handler: { [unowned self] _ in
            filteredDataSource.sort {
                $0.name < $1.name
            }
            collectionView.reloadData()
        })
        let action2 = UIAlertAction(title: "Number of launches", style: .default, handler: { [unowned self] _ in
            filteredDataSource.sort {
                $0.launches.count > $1.launches.count
            }
            collectionView.reloadData()
        })
        let action3 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        action3.setValue(UIColor.red, forKey: "titleTextColor")
        
        alert.addAction(action1)
        alert.addAction(action2)
        alert.addAction(action3)
        
        return alert
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LaunchpadCell.self, forCellWithReuseIdentifier: "LaunchpadCell")
        
        addViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(sortCollection))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        perfomLoadingWithGETRequest()
    }
    
    func addViews() {
        view.addSubview(collectionView)
        view.addSubview(activityIndicator)
    }
    
    @objc func sortCollection() {
        self.present(alertSort, animated: true, completion: nil)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
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
            
            guard let launchpads = try? JSONDecoder().decode([Launchpad].self, from: _data) else { return }
            
            DispatchQueue.main.async { [unowned self] in
                dataSourceLaunchpads = launchpads
                filteredDataSource = launchpads
                collectionView.reloadData()
                activityIndicator.stopAnimating()
            }
            
        })
    }
    
}

// MARK: - UICollectionViewDataSource
extension LaunchpadListVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: LaunchpadCell = collectionView.dequeueReusableCell(withReuseIdentifier: "LaunchpadCell", for: indexPath) as! LaunchpadCell
        
        let object = filteredDataSource[indexPath.item]
        cell.setupLaunchpadCellContent(launchpadObject: object)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension LaunchpadListVC: UICollectionViewDelegateFlowLayout {
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
extension LaunchpadListVC: UICollectionViewDelegate {
    
}

