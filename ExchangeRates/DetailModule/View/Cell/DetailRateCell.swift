//
//  DetailRateCell.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/8/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import UIKit

class DetailRateCell: UICollectionViewCell {
    
    static let reuseId = "GraphFooterView"
    
    // MARK: - UI
    
    private let rateNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private let rateCostLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return label
    }()
    
    private lazy var graphView: GraphView = {
        let view = GraphView(values: [])
        view.translatesAutoresizingMaskIntoConstraints = false
       
        view.backgroundColor = .clear
        return view
    }()

    
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
    }
    
    // MARK: - Public methods
    
    func setup(withRate rate: Rate) {
        graphView.redraw(withValues: rate.rateValus.map { CGFloat($0) })
        rateNameLabel.text = rate.name
        rateCostLabel.text = rate.lastRateValue
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        addSubview(graphView)
        addSubview(rateNameLabel)
        addSubview(rateCostLabel)
       
        // graphView
        graphView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        graphView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1 / 1.5).isActive = true
        graphView.topAnchor.constraint(equalTo: topAnchor, constant: 9).isActive = true
        graphView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9).isActive = true
    
        // rateNameLabel
        rateNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        rateNameLabel.trailingAnchor.constraint(equalTo: graphView.leadingAnchor, constant: -16).isActive = true
        rateNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -8).isActive = true
        
        // rateCostLabel
        rateCostLabel.topAnchor.constraint(equalTo: rateNameLabel.bottomAnchor, constant: 4).isActive = true
        rateCostLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        rateCostLabel.trailingAnchor.constraint(equalTo: graphView.leadingAnchor, constant: -16).isActive = true

    }
}

extension UIColor {
    static let backgroundBlack = UIColor(red: 0.1098039216, green: 0.1098039216, blue: 0.1176470588, alpha: 1)
}
