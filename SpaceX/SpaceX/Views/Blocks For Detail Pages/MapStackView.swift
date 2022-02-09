//
//  MapStackView.swift
//  SpaceX
//
//  Created by Mikita Shalima on 9.02.22.
//

import UIKit
import MapKit

class MapStackView: UIStackView {

    private var label: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "Smoky Black")
        label.font = UIFont(name: "Roboto-Bold", size: 24)
        return label
    }()
    
    private var latitude: Double?
    private var longitude: Double?
    private var locality: String?
    
    private var mapBackgroundSquare: ViewWithTwoShadows = {
        let view = ViewWithTwoShadows(frame: .zero, backgroundColor: UIColor(named: "White"))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "White")
        view.layer.cornerRadius = 20
        return view
    }()
    
    private var map: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        map.layer.cornerRadius = 20
        map.isZoomEnabled = false
        map.isPitchEnabled = false
        map.isRotateEnabled = false
        map.isScrollEnabled = false
        return map
    }()
    
    init(latitude: Double?, longitude: Double?, locality: String?, labelText: String) {
        self.latitude = latitude
        self.longitude = longitude
        self.locality = locality
        self.label.text = labelText
        super.init(frame: .zero)
        
        setupStackView()
        addViews()
        setupConstraints()
        addPlacemarkAndAnnotation()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStackView() {
        axis = .vertical
        alignment = .fill
        spacing = 20
    }
    
    func addViews() {
        addArrangedSubview(label)
        addArrangedSubview(mapBackgroundSquare)
        mapBackgroundSquare.addSubview(map)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mapBackgroundSquare.heightAnchor.constraint(equalTo: mapBackgroundSquare.widthAnchor),
            
            map.leadingAnchor.constraint(equalTo: mapBackgroundSquare.leadingAnchor, constant: 5),
            map.topAnchor.constraint(equalTo: mapBackgroundSquare.topAnchor, constant: 5),
            map.trailingAnchor.constraint(equalTo: mapBackgroundSquare.trailingAnchor, constant: -5),
            map.bottomAnchor.constraint(equalTo: mapBackgroundSquare.bottomAnchor, constant: -5),
        ])
    }
    
    func addPlacemarkAndAnnotation() {
        let coordinates = CLLocationCoordinate2D(latitude: self.latitude!, longitude: self.longitude!)
        map.centerCoordinate = coordinates
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        annotation.title = self.locality
        map.addAnnotation(annotation)
    }

}
