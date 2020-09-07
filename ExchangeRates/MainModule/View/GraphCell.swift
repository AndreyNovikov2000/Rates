//
//  GraphCell.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/5/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import UIKit


class GraphCell: UICollectionViewCell {
    
    static let reuseId = "GraphCell"
    
    
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
        label.text = "12.44"
        return label
    }()
    
    private let baseRateNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 16)
        label.textColor = .white
        label.backgroundColor = #colorLiteral(red: 0.02352941176, green: 0.8392156863, blue: 0.6274509804, alpha: 1)
        label.textAlignment = .center
        label.text = "USD"
        return label
    }()
    
    private lazy var graphView: GraphView = {
        let view = GraphView(values: [])
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        return view
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        baseRateNameLabel.clipsToBounds = true
        baseRateNameLabel.layer.cornerRadius = 7
    }
    
    
    // MARK: - Public methods
    
    func configure(withRate rate: Rate) {
        rateNameLabel.text = rate.name
        graphView.redraw(withValues: rate.rateValus.map { CGFloat($0) })
    }
    
    // MARK: - Private methods
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        addSubview(baseRateNameLabel)
        addSubview(graphView)
        addSubview(rateNameLabel)
        addSubview(rateCostLabel)
        addSubview(separatorView)
        
        // baseRateNameLabel
        baseRateNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        baseRateNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        baseRateNameLabel.widthAnchor.constraint(equalToConstant: 65).isActive = true
        baseRateNameLabel.heightAnchor.constraint(equalToConstant: baseRateNameLabel.font.capHeight + 14).isActive = true
        
        // graphView
        graphView.trailingAnchor.constraint(equalTo: baseRateNameLabel.leadingAnchor, constant: -17).isActive = true
        graphView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/3).isActive = true
        graphView.topAnchor.constraint(equalTo: topAnchor, constant: 7).isActive = true
        graphView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7).isActive = true
        
        // rateNameLabel
        rateNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        rateNameLabel.trailingAnchor.constraint(equalTo: graphView.leadingAnchor, constant: -16).isActive = true
        rateNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -8).isActive = true
        
        // rateCostLabel
        rateCostLabel.topAnchor.constraint(equalTo: rateNameLabel.bottomAnchor, constant: 4).isActive = true
        rateCostLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        rateCostLabel.trailingAnchor.constraint(equalTo: graphView.leadingAnchor, constant: -16).isActive = true

        // separatorView
        separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        separatorView.heightAnchor.constraint(equalToConstant: 0.6).isActive = true
        separatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
}
