// Created for Pomodoro in 2025
// Using Swift 6.0
//
//
// Created by HongYan on 2025/5/30.
// Copyright © 2025 HongYan. All rights reserved.


import Foundation
import AppKit

class MenuStatusBarIconView: NSView {
    let label = NSTextField(labelWithString: "Pomodoro")

    init() {
        super.init(frame: .zero)
        setup()
        layoutView()

        NotificationCenter.default.addObserver(self, selector: #selector(receiveSetWorkTime), name: .setWorkTime, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(receiveSetRestTime), name: .setRestTime, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(receiveEndPomodoro), name: .endPomodoro, object: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        label.isBordered = false
        label.drawsBackground = false
        label.isSelectable = false
        label.isEditable = false
        label.alignment = .center
    }

    private func layoutView() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            label.trailingAnchor.constraint(equalTo: trailingAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

// MARK: - Notification Center
extension MenuStatusBarIconView {
    @objc private func receiveSetWorkTime(_ notification: Notification) {
        guard let time = PNotification.decodeSetWorkTime(notification) else { return }
        label.stringValue = time
        label.textColor = .systemRed
        label.font = .systemFont(ofSize: 12, weight: .semibold)
    }

    @objc private func receiveSetRestTime(_ notification: Notification) {
        guard let time = PNotification.decodeSetRestTime(notification) else { return }
        label.stringValue = time
        label.textColor = .systemGreen
        label.font = .systemFont(ofSize: 12, weight: .semibold)
    }

    @objc private func receiveEndPomodoro(_ notification: Notification) {
        label.stringValue = "Pomodoro"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12, weight: .medium)
    }
}
