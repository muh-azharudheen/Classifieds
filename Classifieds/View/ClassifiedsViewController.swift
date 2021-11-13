//
//  ClassifiedsViewController.swift
//  Classifieds
//
//  Created by Muhammed Azharudheen on 12/11/2021.
//

import UIKit

struct ListViewModel {
    var title: String
    var subtitle: String
    var imageURL: URL?
    var thumbNailURL: URL?
}

struct ClassifiedsViewModel {
    let title: String
    let subTitle: String
    let listTitle: String
}

class ClassifiedsViewController: UIViewController {
    
    private lazy var collectionView = createCollectionView()
    private lazy var viewActivityIndicator = createActivityIndicator()
    
    private var uiModel: ClassifiedsViewModel
    
    var datasource = [ListViewModel]()
    
    init(uiModel: ClassifiedsViewModel) {
        self.uiModel = uiModel
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

extension ClassifiedsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeListCell", for: indexPath) as? HomeListCell else { return UICollectionViewCell() }
        cell.item = datasource[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datasource.count
    }
}

extension ClassifiedsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ClassifiedsViewController: UICollectionViewDelegateFlowLayout {
    
    private var numberOfItemsInRow: CGFloat { 2 }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalWidth = collectionView.bounds.width - collectionViewMargin.left - collectionViewMargin.right
        let totalSpacing: CGFloat = (numberOfItemsInRow - 1) * 16
        let itemWidth = (totalWidth - totalSpacing) / numberOfItemsInRow
        return CGSize(width: itemWidth, height: itemWidth + 40 + 16)
    }
}

private extension ClassifiedsViewController {
    
    func setupViews() {
        view.backgroundColor = .white
        
        let stack = createStackView()
        view.addSubview(stack)
        stack.fill(leading: view.safeAreaLayoutGuide.leadingAnchor,
                   trailing: view.safeAreaLayoutGuide.trailingAnchor,
                   top: view.safeAreaLayoutGuide.topAnchor,
                   insets: .init(top: 24, left: 24, bottom: 0, right: 24))
        
        let labelListingTitle = createLabel(text: uiModel.listTitle, size: 16, color: .primaryDark)
        view.addSubview(labelListingTitle)
        
        labelListingTitle.fill(leading: stack.leadingAnchor,
                               trailing: stack.trailingAnchor,
                               top: stack.bottomAnchor,
                               insets: .init(top: 32, left: 0, bottom: 0, right: 0))
        
        view.addSubview(collectionView)
        collectionView.fill(leading: view.safeAreaLayoutGuide.leadingAnchor,
                            trailing: view.safeAreaLayoutGuide.trailingAnchor,
                            bottom: view.safeAreaLayoutGuide.bottomAnchor,
                            top: labelListingTitle.bottomAnchor)
        
        view.addSubview(viewActivityIndicator)
        viewActivityIndicator.setCenter(to: view)
        viewActivityIndicator.isHidden = true
        
        navigationController?.navigationBar.isHidden = true
    }
    
    private var collectionViewMargin: UIEdgeInsets {
        .init(top: 12, left: 24, bottom: 24, right: 24)
    }
    
    private func createStackView() -> UIStackView {
        let sv = UIStackView(arrangedSubviews: [
                                createLabel(text: uiModel.title, size: 24, color: .secondaryDark),
                                createLabel(text: uiModel.subTitle, size: 16, color: .primaryLight)
                                ])
        sv.axis = .vertical
        sv.spacing = 5
        return sv
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
    
    func createLabel(text: String, size: CGFloat, color: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = CFont.quickSand.font(with: size)
        label.textColor = color
        label.text = text
        return label
    }
    
    func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = false
        return activityIndicator
    }
}
