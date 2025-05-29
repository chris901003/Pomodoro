// Created for Pomodoro in 2025
// Using Swift 6.0
//
//
// Created by HongYan on 2025/5/29.
// Copyright © 2025 HongYan. All rights reserved.


import Foundation
import AppKit
import QuartzCore

class GradientCircleProgressView: NSView {
    private let backgroundLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    private let gradientLayer = CAGradientLayer()

    /// 0.0 ~ 1.0
    var progress: CGFloat = 1.0 {
        didSet {
            progressLayer.strokeEnd = progress
        }
    }

    init() {
        super.init(frame: .zero)
        wantsLayer = true
        setupLayers()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLayers() {
        let radius = min(bounds.width, bounds.height) / 2 - 10
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let circlePath = NSBezierPath()
        circlePath.appendArc(withCenter: center,
                             radius: radius,
                             startAngle: 90,
                             endAngle: -270,
                             clockwise: true)

        // 背景圓圈
        backgroundLayer.path = circlePath.cgPath
        backgroundLayer.strokeColor = NSColor.gray.withAlphaComponent(0.2).cgColor
        backgroundLayer.fillColor = NSColor.clear.cgColor
        backgroundLayer.lineWidth = 10
        layer?.addSublayer(backgroundLayer)

        // 進度圓圈（mask）
        progressLayer.path = circlePath.cgPath
        progressLayer.strokeColor = NSColor.black.cgColor // 實際顏色由 gradientLayer 提供
        progressLayer.fillColor = NSColor.clear.cgColor
        progressLayer.lineWidth = 10
        progressLayer.lineCap = .round
        progressLayer.strokeEnd = progress

        // 漸層圖層
        gradientLayer.frame = bounds
        gradientLayer.colors = [
            NSColor.systemPink.cgColor,
            NSColor.systemPurple.cgColor,
            NSColor.systemBlue.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.mask = progressLayer

        layer?.addSublayer(gradientLayer)
    }

    // 若視圖大小變更時要重新調整圖層
    override func layout() {
        super.layout()

        // 更新圖層大小
        gradientLayer.frame = bounds

        // 重新建立路徑
        let radius = min(bounds.width, bounds.height) / 2 - 10
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let circlePath = NSBezierPath()
        circlePath.appendArc(withCenter: center,
                             radius: radius,
                             startAngle: 90,
                             endAngle: -270,
                             clockwise: true)

        // 套用新路徑
        backgroundLayer.path = circlePath.cgPath
        progressLayer.path = circlePath.cgPath
    }

}
