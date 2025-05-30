// Created for Pomodoro in 2025
// Using Swift 6.0
//
//
// Created by HongYan on 2025/5/30.
// Copyright © 2025 HongYan. All rights reserved.


import Foundation
import AppKit

class CountDownView: NSView {
    let label = NSTextField()

    init() {
        super.init(frame: .zero)
        setup()
        layoutView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func startCountDown(value: Int) {
        guard value > 0 else { return }
        label.stringValue = "\(value)"
        label.wantsLayer = true
        label.alphaValue = 1
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            NSAnimationContext.runAnimationGroup { context in
                context.duration = 0.7
                self.label.animator().alphaValue = 0
            } completionHandler: { [weak self] in
                self?.startCountDown(value: value - 1)
            }
        }
    }

    private func setup() {
        label.font = .systemFont(ofSize: 72, weight: .bold)
        label.wantsLayer = true
        label.isBordered = false
        label.drawsBackground = false
        label.isSelectable = false
        label.isEditable = false
        label.alphaValue = 0
    }

    private func layoutView() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
