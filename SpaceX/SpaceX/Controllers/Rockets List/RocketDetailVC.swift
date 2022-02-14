//
//  RocketDetailVC.swift
//  SpaceX
//
//  Created by Mikita Shalima on 10.02.22.
//

import UIKit

class RocketDetailVC: UIViewController {
    
    var rocketObject: Rocket!
    private let networkManager = NetworkManager()
    private let imageCache = NSCache<NSString, UIImage>()
    
    var mainScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    lazy var headerBlock: RocketDetailHeaderImageView = {
        let imageView = RocketDetailHeaderImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.setup(image: rocketObject.rocketImage, rocketName: rocketObject.name)
        return imageView
    }()
    
    var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.alignment = .fill
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 40, left: 20, bottom: 40, right: 20)
        return stackView
    }()
    
    lazy var descriptionBlock: DescriptionStackView = {
        let stack = DescriptionStackView()
        stack.setup(label: "Description", descriptionText: rocketObject.rocketDescription)
        return stack
    }()
    
    lazy var overviewBlock: TableStackView = {
        let stack = TableStackView()
        stack.setup(label: "Overview")
        stack.addInfo(labelText: "First launch", detailsText: rocketObject.firstFlight.getFormattedDate(formatFrom: "yyyy-MM-dd", formatTo: "MMMM d, yyyy"))
        
        stack.addInfo(labelText: "Launch cost", detailsText: String(rocketObject.costPerLaunch) + "$")
        stack.addInfo(labelText: "Success", detailsText: String(rocketObject.successRatePct) + "%")
        stack.addInfo(labelText: "Mass", detailsText: String(rocketObject.mass.kg))
        stack.addInfo(labelText: "Height", detailsText: String(rocketObject.height.meters))
        stack.addInfo(labelText: "Diameter", detailsText: String(rocketObject.diameter.meters ))
        
        return stack
    }()
    
    lazy var enginesBlock: TableStackView = {
        let stack = TableStackView()
        stack.setup(label: "Engines")
        stack.addInfo(labelText: "Type", detailsText: rocketObject.engines.type)
        stack.addInfo(labelText: "Layout", detailsText: rocketObject.engines.layout)
        stack.addInfo(labelText: "Version", detailsText: rocketObject.engines.version)
        stack.addInfo(labelText: "Amount", detailsText: String(rocketObject.engines.number))
        stack.addInfo(labelText: "Propellant 1", detailsText: rocketObject.engines.propellant1)
        stack.addInfo(labelText: "Propellant 2", detailsText: rocketObject.engines.propellant2)
        
        return stack
    }()
    
    lazy var firstStageBlock: TableStackView = {
        let stack = TableStackView()
        stack.setup(label: "First stage")
        
        stack.addInfo(labelText: "Reusable", detailsText: rocketObject.firstStage.reusable ? "Yes" : "No")
        stack.addInfo(labelText: "Engines amount", detailsText: String(rocketObject.firstStage.engines))
        if let burnTimeSEC = rocketObject.firstStage.burnTimeSEC {
            stack.addInfo(labelText: "Burning time", detailsText: String(burnTimeSEC) + " seconds")
        }
        stack.addInfo(labelText: "Thrust (sea level)", detailsText: String(rocketObject.firstStage.thrustSeaLevel.kN) + " kN")
        stack.addInfo(labelText: "Thrust (vacuum)", detailsText: String(rocketObject.firstStage.thrustVacuum.kN) + " kN")
        
        return stack
    }()
    
    lazy var secondStageBlock: TableStackView = {
        let stack = TableStackView()
        stack.setup(label: "Second stage")
    
        stack.addInfo(labelText: "Reusable", detailsText: rocketObject.secondStage.reusable ? "Yes" : "No")
        stack.addInfo(labelText: "Engines amount", detailsText: String(rocketObject.secondStage.engines))
        if let successRatePct = rocketObject.secondStage.burnTimeSEC {
            stack.addInfo(labelText: "Burning time", detailsText: String(successRatePct) + " seconds")
        }
        stack.addInfo(labelText: "Thrust", detailsText: String(rocketObject.secondStage.thrust.kN) + " kN")
        
        
        return stack
    }()
    
    lazy var landingLegsBlock: TableStackView = {
        let stack = TableStackView()
        stack.setup(label: "Landing legs")
    
        stack.addInfo(labelText: "Amount", detailsText: String(rocketObject.landingLegs.number))
        stack.addInfo(labelText: "Material", detailsText: rocketObject.landingLegs.material)
        
        
        return stack
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "backward"), for: .normal)
        button.addTarget(self, action: #selector(goBackward), for: .touchUpInside)
        return button
    }()
    
    private let flowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.backgroundColor = UIColor.white
        collection.showsHorizontalScrollIndicator = false
        flowLayout.scrollDirection = .horizontal
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        
        addViews()
        addConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tabBarController?.tabBar.isHidden = true
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tabBarController?.tabBar.isHidden = false
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func addViews() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(headerBlock)
        mainScrollView.addSubview(mainStackView)
        view.addSubview(backButton)
        
        mainStackView.addArrangedSubview(descriptionBlock)
        mainStackView.addArrangedSubview(overviewBlock)
        mainStackView.addArrangedSubview(collectionView)
        mainStackView.addArrangedSubview(enginesBlock)
        mainStackView.addArrangedSubview(firstStageBlock)
        mainStackView.addArrangedSubview(secondStageBlock)
        mainStackView.addArrangedSubview(landingLegsBlock)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            mainScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            mainScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            headerBlock.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor),
            headerBlock.topAnchor.constraint(equalTo: mainScrollView.topAnchor),
            headerBlock.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor),
            headerBlock.heightAnchor.constraint(equalTo: headerBlock.widthAnchor),
            
            mainStackView.leadingAnchor.constraint(equalTo: mainScrollView.leadingAnchor),
            mainStackView.topAnchor.constraint(equalTo: headerBlock.bottomAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: mainScrollView.trailingAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: mainScrollView.bottomAnchor),
            mainStackView.centerXAnchor.constraint(equalTo: mainScrollView.centerXAnchor),
            
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            
            collectionView.heightAnchor.constraint(equalToConstant: 210),
        ])
    }
    
    @objc func goBackward() {
        navigationController?.popViewController(animated: true)
    }
    
    func downloadImageForIndexPath(_ indexPath: IndexPath) {
        let urlString = rocketObject.flickrImages[indexPath.item]
    
        networkManager.loadImage(forUrl: urlString) { [unowned self] image in
            DispatchQueue.main.async {
                imageCache.setObject(image!, forKey: urlString as NSString)
                collectionView.reloadItems(at: [indexPath])
            }
        }
    }
    
}

// MARK: - UICollectionViewDataSource
extension RocketDetailVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        rocketObject.flickrImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        if let image = imageCache.object(forKey: rocketObject.flickrImages[indexPath.item] as NSString) {
            cell.rocketImage.image = image
        } else {
            downloadImageForIndexPath(indexPath)
        }
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension RocketDetailVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return  CGSize(width: collectionView.frame.height * 0.75, height: collectionView.frame.height - 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        20
    }
}

//MARK: - UICollectionViewDelegate
extension RocketDetailVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageBrowsingVC = ImageBrowsingVC()
        imageBrowsingVC.imageView.image = imageCache.object(forKey: rocketObject.flickrImages[indexPath.item] as NSString)
        navigationController?.pushViewController(imageBrowsingVC, animated: true)
    }
}

