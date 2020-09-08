//
//  GraphView.swift
//  ExchangeRates
//
//  Created by Andrey Novikov on 9/6/20.
//  Copyright © 2020 Andrey Novikov. All rights reserved.
//

import UIKit

class GraphView: UIView {
    
    enum AnimationKey: String {
        case pathAnimation
    }
    
    // MARK: - Private properties
    
    private let pathShapeLayer = CAShapeLayer()
    private let gradientShapeLayer = CAShapeLayer()
    private let gradientLayer = CAGradientLayer()
    
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
    
    private var pathAnimationIsComplite = false
    
    // MARK: - Init
    
    init(values: [CGFloat]) {
        self.values = values
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard let _ = UIGraphicsGetCurrentContext() else { return }
        setupGradientShapeLayer()
        setupShapePathLayer()
        setupGradintLayer()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.setupAnimation()
        }
    }
    
    
    // MARK: - Public methods
    
    func redraw(withValues values: [CGFloat]) {
        self.values = values
        
        gradientLayer.removeFromSuperlayer()
        gradientShapeLayer.removeFromSuperlayer()
        
        setNeedsDisplay()
    }
    
    // MARK: - Private methods
    
    private func getYPosition(fromValusIndex index: Int) -> CGFloat {
        let value = values[index]
        let steepValue: CGFloat = minValue - value
        
        if value == minValue {
            return 0
        }
        
        return -(steepValue * yRatio)
    }
    
    private func getPath(forGradient: Bool) -> UIBezierPath {
        let path = UIBezierPath()
        let steep = frame.width / CGFloat(values.count-1)
        var xStepPoint = steep
        
        path.move(to: CGPoint(x: 0, y: getYPosition(fromValusIndex: 0)))
        
        for index in (0..<values.count) {
            guard index != 0 else { continue }
            let point = CGPoint(x: xStepPoint, y: getYPosition(fromValusIndex: index))
            path.addLine(to: point)
            xStepPoint += steep
        }
        
        guard forGradient else { return path }
        
        path.addLine(to: CGPoint(x: frame.width, y: frame.height))
        path.addLine(to: CGPoint(x: 0, y: frame.height))
        path.addLine(to: CGPoint(x: 0, y: getYPosition(fromValusIndex: 0)))
        
        return path
    }
    
    // MARK: - Setup
    
    private func setupGradientShapeLayer() {
        shapeLayer.path = getPath(forGradient: true).cgPath
        shapeLayer.strokeColor = UIColor.clear.cgColor
        shapeLayer.frame = bounds
    }
    
    private func setupGradintLayer() {
        
        gradientLayer.frame = bounds
        gradientLayer.colors = GraphConstants.gradientColors
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        gradientLayer.mask = shapeLayer
        
        layer.addSublayer(gradientLayer)
    }
    
    
    private func setupShapePathLayer() {
        pathShapeLayer.path = getPath(forGradient: false).cgPath
        pathShapeLayer.frame = bounds
        pathShapeLayer.strokeColor = pathAnimationIsComplite ? GraphConstants.strokeColor.cgColor : UIColor.clear.cgColor
        pathShapeLayer.lineWidth =  GraphConstants.lineWidth
        shapeLayer.strokeStart = 0
        shapeLayer.strokeEnd = 1
        
        layer.addSublayer(pathShapeLayer)
    }
    
    private func setupAnimation() {
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.fromValue = 0
        pathAnimation.toValue = 1
        pathAnimation.duration = 0.5
        pathAnimation.timingFunction = .init(name: .linear)
        pathAnimation.delegate = self
        
        if !pathAnimationIsComplite {
            pathShapeLayer.add(pathAnimation, forKey: AnimationKey.pathAnimation.rawValue)
        }
    }
}


// MARK: - CAAnimationDelegate

extension GraphView: CAAnimationDelegate {
    func animationDidStart(_ anim: CAAnimation) {
        pathShapeLayer.strokeColor = GraphConstants.strokeColor.cgColor
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        pathShapeLayer.removeAnimation(forKey: AnimationKey.pathAnimation.rawValue)
        pathAnimationIsComplite = true
    }
}

