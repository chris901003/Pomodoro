// Created for Pomodoro in 2025
// Using Swift 6.0
//
//
// Created by HongYan on 2025/5/28.
// Copyright © 2025 HongYan. All rights reserved.


import Foundation
import Cocoa

class StartButtonView: NSView {
    let circleView = NSView()
    let labelView = NSTextField()

    init() {
        super.init(frame: .zero)
        setup()
        layoutView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        circleView.wantsLayer = true
        circleView.layer?.cornerRadius = 40
        circleView.layer?.borderWidth = 2.0
        circleView.layer?.borderColor = NSColor.systemGreen.cgColor

        labelView.stringValue = "Start"
        labelView.font = .systemFont(ofSize: 14, weight: .bold)
        labelView.textColor = .systemGreen
        labelView.maximumNumberOfLines = 1
        labelView.alignment = .center
        labelView.isBordered = false
        labelView.drawsBackground = false
        labelView.isSelectable = false
        labelView.isEditable = false
    }

    private func layoutView() {
        addSubview(circleView)
        circleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: topAnchor),
            circleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            circleView.trailingAnchor.constraint(equalTo: trailingAnchor),
            circleView.bottomAnchor.constraint(equalTo: bottomAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 80),
            circleView.heightAnchor.constraint(equalToConstant: 80)
        ])

        addSubview(labelView)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            labelView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor)
        ])
    }
}
