//
//  RocketDetailVC.swift
//  SpaceX
//
//  Created by Mikita Shalima on 10.02.22.
//

import UIKit

class RocketDetailVC: UIViewController {
    
    var rocketObject: Rocket?
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
        imageView.setup(image: rocketObject?.rocketImage, rocketName: rocketObject?.name)
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
        stack.setup(label: "Description", descriptionText: rocketObject?.rocketDescription)
        return stack
    }()
    
    lazy var overviewBlock: TableStackView = {
        let stack = TableStackView()
        stack.setup(label: "Overview")
        stack.addInfo(labelText: "First launch", detailsText: rocketObject?.firstFlight.getFormattedDate(formatFrom: "yyyy-MM-dd", formatTo: "MMMM d, yyyy"))
        if let costPerLaunch = rocketObject?.costPerLaunch {
            stack.addInfo(labelText: "Launch cost", detailsText: String(costPerLaunch) + "$")
        }
        if let successRatePct = rocketObject?.successRatePct {
            stack.addInfo(labelText: "Success", detailsText: String(successRatePct) + "%")
        }
        if let mass = rocketObject?.mass.kg {
            stack.addInfo(labelText: "Mass", detailsText: String(mass))
        }
        if let height = rocketObject?.height.meters {
            stack.addInfo(labelText: "Height", detailsText: String(height))
        }
        if let diameter = rocketObject?.diameter.meters {
            stack.addInfo(labelText: "Diameter", detailsText: String(diameter))
        }
        
        return stack
    }()
    
    lazy var enginesBlock: TableStackView = {
        let stack = TableStackView()
        stack.setup(label: "Engines")
        stack.addInfo(labelText: "Type", detailsText: rocketObject?.engines.type)
        stack.addInfo(labelText: "Layout", detailsText: rocketObject?.engines.layout)
        stack.addInfo(labelText: "Version", detailsText: rocketObject?.engines.version)
        if let number = rocketObject?.engines.number {
            stack.addInfo(labelText: "Amount", detailsText: String(number))
        }
        stack.addInfo(labelText: "Propellant 1", detailsText: rocketObject?.engines.propellant1)
        stack.addInfo(labelText: "Propellant 2", detailsText: rocketObject?.engines.propellant2)
        
        return stack
    }()
    
    lazy var firstStageBlock: TableStackView = {
        let stack = TableStackView()
        stack.setup(label: "First stage")
    
        if let reusable = rocketObject?.firstStage.reusable {
            stack.addInfo(labelText: "Reusable", detailsText: reusable ? "Yes" : "No")
        }
        if let costPerLaunch = rocketObject?.firstStage.engines {
            stack.addInfo(labelText: "Engines amount", detailsText: String(costPerLaunch))
        }
        if let successRatePct = rocketObject?.firstStage.burnTimeSEC {
            stack.addInfo(labelText: "Burning time", detailsText: String(successRatePct) + "seconds")
        }
        if let mass = rocketObject?.firstStage.thrustSeaLevel.kN {
            stack.addInfo(labelText: "Thrust (sea level)", detailsText: String(mass) + "kN")
        }
        if let height = rocketObject?.firstStage.thrustVacuum.kN {
            stack.addInfo(labelText: "Thrust (vacuum)", detailsText: String(height) + "kN")
        }
        
        return stack
    }()
    
    lazy var secondStageBlock: TableStackView = {
        let stack = TableStackView()
        stack.setup(label: "Second stage")
    
        if let reusable = rocketObject?.firstStage.reusable {
            stack.addInfo(labelText: "Reusable", detailsText: reusable ? "Yes" : "No")
        }
        if let costPerLaunch = rocketObject?.firstStage.engines {
            stack.addInfo(labelText: "Engines amount", detailsText: String(costPerLaunch))
        }
        if let successRatePct = rocketObject?.firstStage.burnTimeSEC {
            stack.addInfo(labelText: "Burning time", detailsText: String(successRatePct) + "seconds")
        }
        if let mass = rocketObject?.firstStage.thrustSeaLevel.kN {
            stack.addInfo(labelText: "Thrust", detailsText: String(mass) + "kN")
        }
        
        return stack
    }()
    
    lazy var landingLegsBlock: TableStackView = {
        let stack = TableStackView()
        stack.setup(label: "Landing legs")
    
        if let amount = rocketObject?.landingLegs.number {
            stack.addInfo(labelText: "Amount", detailsText: String(amount))
        }
        stack.addInfo(labelText: "Material", detailsText: rocketObject?.landingLegs.material)
        
        
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
        navigationController?.navigationBar.isHidden = true
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
        let urlString = rocketObject!.flickrImages[indexPath.item]
    
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
        (rocketObject?.flickrImages.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: ImageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        
        if let image = imageCache.object(forKey: (rocketObject?.flickrImages[indexPath.item])! as NSString) {
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
    
    }
}

