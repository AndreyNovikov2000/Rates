//
//  DetailViewController.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/7/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import UIKit
import Combine


class DetailViewController: UIViewController {
    
    // MARK: - Public properties
    
    var presenter: DetailPresenterProtocol?
    
    // MARK: - Private properties
    
    private var selectedRate: Rate?
    private var rates: [Rate]?
    private var timeIntervalRates: [Rate]?
    
    
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<DetailSectionType, Rate>!
    
    enum DetailSectionType: Int, CaseIterable {
        case detailCell
        case dayCell
    }
    
    
    // MARK: - Live cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.getRate()
        presenter?.getRates()
        presenter?.getRequestsTimeInterval(withRateInterval: RateInterval())
        
        setupNavigationController()
        setupCollectionView()
        setupDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupNavigationController()
    }
    
    // MARK: - Private methods
    
    private func reloadData() {
        var snapshot = NSDiffableDataSourceSnapshot<DetailSectionType, Rate>.init()
        
        snapshot.appendSections(DetailSectionType.allCases)
        snapshot.appendItems(rates ?? [], toSection: .detailCell)
        snapshot.appendItems(timeIntervalRates ?? [], toSection: .dayCell)
        
        dataSource.apply(snapshot)
    }
}


// MARK: - Setup

extension DetailViewController {
    private func setupNavigationController() {
        navigationController?.navigationBar.topItem?.title = ""
        navigationItem.title = selectedRate?.name
    }
    
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleWidth]
        collectionView.backgroundColor = .backgroundBlack
        collectionView.collectionViewLayout = setupCompositionalLayout()
        collectionView.delegate = self
        
        collectionView.register(DetailRateCell.self, forCellWithReuseIdentifier: DetailRateCell.reuseId)
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: DayCell.reuseId)
        collectionView.register(GraphFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: GraphFooterView.reuseId)
        
        
        view.addSubview(collectionView)
    }
    
    private func setupCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (section, enviroment) -> NSCollectionLayoutSection? in
            guard let section = DetailSectionType(rawValue: section) else { return nil }
            
            switch section {
            case .detailCell:
                return self.setupDetailSection()
            case .dayCell:
                return self.setupDaySection()
            }
        }
        
        return layout
    }
    
    
    private func setupDetailSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.leading = 10
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 1.2), heightDimension: .absolute(80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 10)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        section.interGroupSpacing = 10
        section.contentInsets.top = 10
        section.contentInsets.bottom = 16
        
        return section
    }
    
    private func setupDaySection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1 / 6), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets.leading = 16
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        let footerView = setupBoundarySupplementaryItemForDetailSection()
        section.boundarySupplementaryItems = [footerView]
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets.bottom = 10
        
        return section
    }
    
    
    
    private func setupBoundarySupplementaryItemForDetailSection() -> NSCollectionLayoutBoundarySupplementaryItem {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(1))
        let item = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: itemSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottom)
        return item
    }
    
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<DetailSectionType, Rate>.init(collectionView: collectionView, cellProvider: { (collectionView, indexPath, rate) -> UICollectionViewCell? in
            guard let section = DetailSectionType(rawValue: indexPath.section) else { return nil }
            
            switch section {
            case .detailCell:
                return collectionView.dequeuCell(withValue: rate, forIndexPath: indexPath, ofType: DetailRateCell.self)
            case .dayCell:
                return collectionView.dequeuCell(withValue: rate, forIndexPath: indexPath, ofType: DayCell.self)
            }
        })
        
        
        dataSource.supplementaryViewProvider = { (collectionView, kind, indexPath) -> UICollectionReusableView? in
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: GraphFooterView.reuseId, for: indexPath) as? GraphFooterView
            footerView?.configure(withRate: self.selectedRate)
            return footerView
        }
        
        reloadData()
    }
}


// MARK: - UICollectionViewDelegate

extension DetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let section = DetailSectionType(rawValue: indexPath.section) else { return }
        guard let rate = dataSource.itemIdentifier(for: indexPath) else { return }
        guard let rates = rates else { return }
        
        
        switch section {
        case .detailCell:
            presenter?.didSelectRate(rates: rates, selectedRate: rate)
        case .dayCell:
            print(indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let section = DetailSectionType(rawValue: indexPath.section) else { return }
        
        switch section {
        case .detailCell:
            break
        case .dayCell:
            let dayCell = collectionView.cellForItem(at: indexPath) as? DayCell
            if indexPath.item == 0  {
                dayCell?.isSelected = true
            }
        }
    }
}

// MARK: - DetailViewProtocol

extension DetailViewController: DetailViewProtocol {
    func setRate(_ rate: Rate) {
        self.selectedRate = rate
    }
    
    func setRates(_ rates: [Rate]) {
        self.rates = rates
    }
    
    func setRequestsTimeInterval(_ rates: [Rate]) {
        self.timeIntervalRates = rates
    }
}

