//
//  DayCell.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/10/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import UIKit



class DayCell: UICollectionViewCell, RateCellConfigure {
    
    static let reuseId = "DayCell"
    
    // MARK: - Public properties
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .gray : .black
            
            if isSelected {
                UIView.animate(withDuration: 0.25) {
                    self.transform = CGAffineTransform(scaleX: 1.11, y: 1.11)
                }
            } else {
                UIView.animate(withDuration: 0.25) {
                    self.transform = .identity
                }
            }
        }
    }
    
    // MARK: - Private properties
    
    private let calendar = Calendar.current
    private let rateLabel = RateLabel()
    
    // MARK: - Live cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
        backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        layer.masksToBounds = true
        layer.cornerRadius = 12
    }
    
    // MARK: - Public methods
    
    func configure<H>(withValue value: H) where H : Hashable {
        guard let rate = value as? Rate else { return }
        let passTime = calendar.getPastTime(fromDate: rate.fromDate)
        
        switch passTime.components {
        case .day:
            rateLabel.text = "\(passTime.numberOfComponents)d"
        case .mouth:
            rateLabel.text = "\(passTime.numberOfComponents)m"
        case .year:
            rateLabel.text = "\(passTime.numberOfComponents)y"
        }
    }
    
    
    // MARK: - Private methods
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        addSubview(rateLabel)
        
        // rateLabel
        NSLayoutConstraint.activate([
            rateLabel.topAnchor.constraint(equalTo: topAnchor),
            rateLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            rateLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            rateLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
