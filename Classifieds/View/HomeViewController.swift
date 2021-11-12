//
//  HomeViewController.swift
//  Classifieds
//
//  Created by Muhammed Azharudheen on 12/11/2021.
//

import UIKit

struct List {
    var title: String
    var subtitle: String
    var imageURL: String?
}

class HomeViewController: UIViewController {
    
    private lazy var collectionView = createCollectionView()
    
    private var lists: [List]
    private var listTitle: String
    
    init(lists: [List], listTitle: String) {
        self.lists = lists
        self.listTitle = listTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeListCell", for: indexPath) as? HomeListCell else { return UICollectionViewCell() }
        cell.list = lists[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return lists.count
    }
}

extension HomeViewController: UICollectionViewDelegate { }

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    private var numberOfItemsInRow: CGFloat { 2 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = collectionView.bounds.width - collectionViewMargin.left - collectionViewMargin.right
        let totalSpacing: CGFloat = (numberOfItemsInRow - 1) * 16
        let itemWidth = (totalWidth - totalSpacing) / numberOfItemsInRow
        return CGSize(width: itemWidth, height: itemWidth + 40 + 16)
    }
}

private extension HomeViewController {
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        let stack = UIStackView(arrangedSubviews: [
                                createLabel(text: "Hello, Dubizzle"),
                                createLabel(text: "May 12, Sunday")
                                ])
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 3
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])
        
        let newLabel = createLabel(text: listTitle)
        view.addSubview(newLabel)
        
        NSLayoutConstraint.activate([
            newLabel.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 36),
            newLabel.leadingAnchor.constraint(equalTo: stack.leadingAnchor),
            newLabel.trailingAnchor.constraint(equalTo: stack.trailingAnchor),
        ])
                
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: newLabel.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        navigationController?.navigationBar.isHidden = true
    }
    
    private var collectionViewMargin: UIEdgeInsets {
        .init(top: 24, left: 24, bottom: 24, right: 24)
    }
    
    func createCollectionView() -> UICollectionView {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.contentInset = collectionViewMargin
        cv.register(UINib(nibName: "HomeListCell", bundle: nil), forCellWithReuseIdentifier: "HomeListCell")
        return cv
    }
    
    func createLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        return label
    }
}
