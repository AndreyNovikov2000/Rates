//
//  GraphView.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/6/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import UIKit

class GraphView: UIView {
    
    // MARK: - Private properties
    
    private var shapeLayer = CAShapeLayer()
    private var values: [CGFloat]
    
    private var minValue: CGFloat {
        return values.min() ?? 0
    }
    
    private var maxValue: CGFloat {
        return values.max() ?? 0
    }
    
    private var medina: CGFloat {
        return (minValue + maxValue) / 2
    }
    
    private var yRatio: CGFloat {
        return frame.height / (maxValue - minValue)
    }
    
    // MARK: - Init
    
    init(values: [CGFloat]) {
        self.values = values
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        draw(inContext: context)
    }
    
    
    // MARK: - Public methods
    
    func redraw(withValues values: [CGFloat]) {
        self.values = values
        setNeedsDisplay()
    }
    
    // MARK: - Private methods
    
    private func draw(inContext context: CGContext) {
        drawPath(inContext: context)
        
        context.setStrokeColor(GraphConstants.strokeColor.cgColor)
        context.strokePath()
        context.setLineWidth(GraphConstants.lineWidth)
    }

    
    private func drawPath(inContext context: CGContext) {
        let steep = frame.width / CGFloat(values.count-1)
        var xStepPoint = steep
        
        context.move(to: CGPoint(x: 0, y: getYPosition(fromValusIndex: 0)))
        
        for index in (0..<values.count) {
            guard index != 0 else { continue }
            let point = CGPoint(x: xStepPoint, y: getYPosition(fromValusIndex: index))
            context.addLine(to: point)
            xStepPoint += steep
        }
    }
    
    private func getYPosition(fromValusIndex index: Int) -> CGFloat {
        let value = values[index]
        let steepValue: CGFloat = minValue - value
        
        if value == minValue {
            return 0
        }
        
        return -(steepValue * yRatio)
    }
}

