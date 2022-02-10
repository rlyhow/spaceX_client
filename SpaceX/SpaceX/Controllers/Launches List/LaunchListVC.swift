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
        
        let action1 = UIAlertAction(title: "Launch date", style: .default, handler: { [unowned self] _ in
            filteredDataSource.sort {
                $0.dateUTC > $1.dateUTC
            }
            collectionView.reloadData()
        })
        let action2 = UIAlertAction(title: "Title", style: .default, handler: { [unowned self] _ in
            filteredDataSource.sort {
                $0.name < $1.name
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
    
    private lazy var filter: FilterSegmentedControl = {
        let segment = FilterSegmentedControl("All", "Past", "Future")
        segment.addTarget(self, action: #selector(applyFilter), for: .valueChanged)
        return segment
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(LaunchCell.self, forCellWithReuseIdentifier: "LaunchCell")
        
        addViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.titleView = filter
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(sortCollection))
        filter.selectedSegmentIndex = 0
        tabBarController?.tabBar.isHidden = false
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
    
    @objc func applyFilter(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex) {
        case 0:
            filteredDataSource = dataSourceLaunches.filter({ launch in
                return true
            })
        case 1:
            filteredDataSource = dataSourceLaunches.filter({ launch in
                if !compareTwoDates(date: launch.dateUTC) {
                    return true
                } else { return false }
            })
        case 2:
            filteredDataSource = dataSourceLaunches.filter({ launch in
                if compareTwoDates(date: launch.dateUTC) {
                    return true
                } else { return false }
            })
        default:
            break
        }
        collectionView.reloadData()
    }
    
    func compareTwoDates(date: String) -> Bool {
        let currentDate = Date()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        guard let launchDate = dateFormatter.date(from: date) else {
            return false
        }
        
        if currentDate.compare(launchDate) == .orderedAscending {
            return true
        }
        return false
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
            
            guard let launches = try? JSONDecoder().decode([Launch].self, from: _data) else { return }
            
            DispatchQueue.main.async { [unowned self] in
                dataSourceLaunches = launches
                filteredDataSource = launches
                collectionView.reloadData()
                activityIndicator.stopAnimating()
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
                dataSourceLaunches[indexPath.item].patchImage = image
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let launchDetailVC = LaunchDetailVC()
        launchDetailVC.launchObject = filteredDataSource[indexPath.item]
        navigationController?.pushViewController(launchDetailVC, animated: true)
    }
}
