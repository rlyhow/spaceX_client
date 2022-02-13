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
    
    let closeButton: CloseButton = {
        let button = CloseButton()
        button.addTarget(self, action: #selector(goBackward), for: .touchUpInside)
        return button
    }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        scrollView.delegate = self
        addViews()
        addConstraints()
        
        let scrollViewTap = UITapGestureRecognizer(target: self, action: #selector(scrollViewTapped))
        scrollView.addGestureRecognizer(scrollViewTap)
    }
    
    func addViews() {
        view.addSubview(scrollView)
        view.addSubview(closeButton)
        
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
            
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64),
            closeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            closeButton.widthAnchor.constraint(equalToConstant: 36),
            closeButton.heightAnchor.constraint(equalToConstant: 36),
        ])
    }
    
    @objc func goBackward() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func scrollViewTapped() {
        if closeButton.isHidden == true {
            closeButton.isHidden = false
            closeButton.isEnabled = true
            view.backgroundColor = .white
        } else {
            closeButton.isHidden = true
            closeButton.isEnabled = false
            view.backgroundColor = .black
        }
    }

}

extension ImageBrowsingVC: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        scrollView.subviews.first
    }
}
