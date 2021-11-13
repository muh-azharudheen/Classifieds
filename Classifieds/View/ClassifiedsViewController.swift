//
//  ClassifiedsViewController.swift
//  Classifieds
//
//  Created by Muhammed Azharudheen on 12/11/2021.
//

import UIKit

class ClassifiedsViewController: UIViewController {
    
    private (set) lazy var collectionView = createCollectionView()
    private lazy var viewActivityIndicator = createActivityIndicator()
    
    private var viewModel: ClassifiedsViewModelProtocol
    
    private (set) lazy var labelTitle = createLabel(text: viewModel.title, size: 24, color: .secondaryDark)
    private (set) lazy var labelSubTitle = createLabel(text: viewModel.subTitle, size: 16, color: .primaryLight)
    private (set) lazy var labelListingTitle = createLabel(text: viewModel.listTitle, size: 16, color: .primaryDark)
    
    init(viewModel: ClassifiedsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        configureViewModel()
        loadLists()
    }
}

private extension ClassifiedsViewController {
    
    func loadLists() {
        viewActivityIndicator.startAnimating()
        viewModel.loadLists()
    }
    
    func didUpdateLists() {
        viewActivityIndicator.stopAnimating()
        collectionView.reloadData()
    }
    
    func configureViewModel() {
        
        viewModel.reloadClosure = { [weak self] in
            self?.didUpdateLists()
        }
        
        viewModel.showDetailClosure = { [unowned self] in
            self.showDetailViewController(viewModel: $0)
        }
    }
}

private extension ClassifiedsViewController {
    
    func showDetailViewController(viewModel: DetailViewModel) {
        guard let controller = UIStoryboard(name: "Detail", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
        controller.viewModel = viewModel
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension ClassifiedsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeListCell", for: indexPath) as? ClassifiedListCell else { return UICollectionViewCell() }
        cell.item = viewModel.list(index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfLists()
    }
}

extension ClassifiedsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.selectItem(at: indexPath.item)
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
        
        navigationController?.navigationBar.isHidden = true
    }
    
    private var collectionViewMargin: UIEdgeInsets {
        .init(top: 12, left: 24, bottom: 24, right: 24)
    }
    
    private func createStackView() -> UIStackView {
        let sv = UIStackView(arrangedSubviews: [labelTitle, labelSubTitle])
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
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }
}
