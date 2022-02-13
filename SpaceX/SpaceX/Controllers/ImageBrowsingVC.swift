//
//  ImageBrowsingVC.swift
//  SpaceX
//
//  Created by Mikita Shalima on 13.02.22.
//

import UIKit

class ImageBrowsingVC: UIViewController {

    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.maximumZoomScale = 3
        scroll.minimumZoomScale = 1
        
        return scroll
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        scrollView.delegate = self
        addViews()
        addConstraints()
    }
    
    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                   
            scrollView.contentLayoutGuide.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            scrollView.contentLayoutGuide.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
        ])
    }

}

extension ImageBrowsingVC: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        scrollView.subviews.first
    }
}
