//
//  GraphFooTerView.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/8/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import UIKit

class GraphFooterView: UICollectionReusableView {
    
    static let reuseId = "GraphFooterView"
    
    
    // MARK: - UI
    
    private let graphView: GraphView = {
        let view = GraphView(values: [])
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let heightsRateLabel = RateLabel()
    private let medinaHeighstRateLabel = RateLabel()
    private let medinaRateLabel = RateLabel()
    private let lowerstMedinaRateLabel = RateLabel()
    private let lowerstRateLabel = RateLabel()
    
    
    // MARK: - Private properties
    
    private var numberOfLines = 5
    private var space: CGFloat {
        return bounds.width / CGFloat(numberOfLines)
    }
    private var spaceWidth: CGFloat {
        return space / CGFloat(numberOfLines)
    }
    
    
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
        
        drawSquareGrid()
    }
    
    // MARK: - Public methods
    
    func configure(withRate rate: Rate?) {
        guard let rate = rate else { return }
        graphView.redraw(withValues: rate.rateValus.map { CGFloat($0) })
        
        heightsRateLabel.text = rate.getRate(withRateValue: .maxRateValue)
        medinaHeighstRateLabel.text = rate.getRate(withRateValue: .medinaMaxRateValue)
        medinaRateLabel.text = rate.getRate(withRateValue: .medinaRateValue)
        lowerstMedinaRateLabel.text = rate.getRate(withRateValue: .medinaMinRateValue)
        lowerstRateLabel.text = rate.getRate(withRateValue: .minRateValue)
        drawMedina(withRate: rate)
    }
    
    // MARK: - Private methods
    
    private func drawSquareGrid() {
        
        // draw vertical lines
        (0...numberOfLines).forEach { factor in
            let view = UIView()
            view.frame = CGRect(x: CGFloat(factor) * space, y: 0, width: 0.2, height: bounds.height)
            view.backgroundColor = .white
            addSubview(view)
        }
        
        // draw horizontal lines
        
        (0...numberOfLines).forEach { factor in
            let view = UIView()
            view.frame = CGRect(x: 0, y: CGFloat(factor) * space, width: bounds.width, height: 0.2)
            view.backgroundColor = .white
            addSubview(view)
        }
    }
    
    private func drawMedina(withRate rate: Rate) {
        let numberOfLines: Int = 100
        let width = ((frame.width - spaceWidth) / CGFloat(numberOfLines))
        let ratio = frame.height / CGFloat(rate.maxRateValue - rate.minRateValue)
        let minRate: CGFloat = CGFloat(rate.rateValus.min() ?? 0)
        let medina: CGFloat = CGFloat(rate.med)
        let yPosition = (medina - minRate) * ratio
        
        (1...numberOfLines).forEach { index in
            if !(index % 2 == 0) {
                let view = UIView()
                view.frame = CGRect(x: CGFloat(index) * width, y: yPosition, width: width, height: 0.3)
                view.backgroundColor = .white
                addSubview(view)
            }
        }
    }
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        addSubview(graphView)
        addSubview(heightsRateLabel)
        addSubview(medinaHeighstRateLabel)
        addSubview(medinaRateLabel)
        addSubview(lowerstMedinaRateLabel)
        addSubview(lowerstRateLabel)
        
        
        
        // graphView
        NSLayoutConstraint.activate([
            graphView.topAnchor.constraint(equalTo: topAnchor),
            graphView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -frame.height / 5),
            graphView.leadingAnchor.constraint(equalTo: leadingAnchor),
            graphView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -frame.width / 5)
        ])
        
        setupConstraintsForVerticaleLabel(heightsRateLabel, index: 0)
        setupConstraintsForVerticaleLabel(medinaHeighstRateLabel, index: 1)
        setupConstraintsForVerticaleLabel(medinaRateLabel, index: 2)
        setupConstraintsForVerticaleLabel(lowerstMedinaRateLabel, index: 3)
        setupConstraintsForVerticaleLabel(lowerstRateLabel, index: 4)
        
    }
    
    func setupConstraintsForVerticaleLabel(_ label: UILabel, index: Int) {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: space * CGFloat(index) + 5),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            label.widthAnchor.constraint(equalToConstant: frame.width / 5 - 20)
        ])
    }
}
