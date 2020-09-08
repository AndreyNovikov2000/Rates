//
//  MainViewController.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/5/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Proprties
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var presenter: MainPresenterProtocol?
    
    // MARK: - Private properties
    
    private var rateWrapped = RateWrapped()
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<LayoutSections, Rate>!
    
    private enum LayoutSections: Int, CaseIterable {
        case graphSection
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.loadTimeSeriesRates()
    
        setupCollectionView()
        setupDiffableDataSorce()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationController()
    }
    
    // MARK: - Private methods
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<LayoutSections, Rate>.init()
        snapshot.appendSections(LayoutSections.allCases)
        snapshot.appendItems(rateWrapped.rates, toSection: .graphSection)
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
}

// MARK: - Setup

extension MainViewController {
    
    private func setupNavigationController() {
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        
        
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Series rate"
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .black
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.collectionViewLayout = setupCompositionLayout()
        collectionView.register(GraphCell.self, forCellWithReuseIdentifier: GraphCell.reuseId)
        collectionView.delegate = self
        
        view.addSubview(collectionView)
    }
    
    private func setupCompositionLayout() -> UICollectionViewLayout {
        let compositionalLayout = UICollectionViewCompositionalLayout { (section, enviroment) -> NSCollectionLayoutSection? in
            guard let section = LayoutSections(rawValue: section) else { return nil }
            
            switch section {
            case .graphSection:
                return self.setupGraphSection()
            }
        }
        
        return compositionalLayout
    }
    
    private func setupGraphSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.bottom = 3
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(70))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.top = 20
        section.contentInsets.bottom = 20
        
        return section
    }
    
    private func setupDiffableDataSorce() {
        dataSource = .init(collectionView: collectionView, cellProvider: { (collectionView, indexPath, rate) -> UICollectionViewCell? in
            guard let section = LayoutSections(rawValue: indexPath.section) else { return nil }
            
            switch section  {
            case .graphSection:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GraphCell.reuseId, for: indexPath) as? GraphCell
                cell?.configure(withRate: rate)
                return cell
            }
        })
        
        reloadData()
    }
}

// MARK: - MainViewProtocol

extension MainViewController: MainViewProtocol {
    func getTimeSeriesRates(withResult result: Result<RateWrapped, Error>) {
        switch result {
        case .success(let rateWrapped):
            self.rateWrapped = rateWrapped
            self.reloadData()
        case .failure(let error):
            self.showAlert(title: "Error!", message: error.localizedDescription)
        }
    }
}

// MARK: - UIcollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let rate = dataSource.itemIdentifier(for: indexPath) else { return }
        let detailVC = Builder.buildDetailModule(withRates: rateWrapped.rates, selectedRate: rate)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
