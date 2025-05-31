// Created for Pomodoro in 2025
// Using Swift 6.0
//
//
// Created by HongYan on 2025/5/31.
// Copyright © 2025 HongYan. All rights reserved.


import Foundation
import AppKit

class QuitButtonView: NSView {
    let closeLabel = NSTextField(labelWithString: "退出")

    init() {
        super.init(frame: .zero)
        setup()
        layoutView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        closeLabel.textColor = .systemRed
        closeLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        closeLabel.isBordered = false
        closeLabel.drawsBackground = false
        closeLabel.isSelectable = false
        closeLabel.isEditable = false

        let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(handleClick))
        closeLabel.addGestureRecognizer(clickGesture)
    }

    private func layoutView() {
        addSubview(closeLabel)
        closeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closeLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            closeLabel.topAnchor.constraint(equalTo: topAnchor),
            closeLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            closeLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @objc private func handleClick() {
        NSApp.terminate(nil)
    }
}
