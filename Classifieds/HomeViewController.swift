//
//  HomeViewController.swift
//  Classifieds
//
//  Created by Muhammed Azharudheen on 12/11/2021.
//

import UIKit

class HomeViewController: UIViewController {
    
    private lazy var collectionView = createCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

private extension HomeViewController {
    func createCollectionView() -> UICollectionView {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .red
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }
}
