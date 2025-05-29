// Created for Pomodoro in 2025
// Using Swift 6.0
//
//
// Created by HongYan on 2025/5/29.
// Copyright © 2025 HongYan. All rights reserved.


import Foundation
import AppKit

class SetRoundView: NSView {
    let titleLabelView = NSTextField(labelWithString: "輪數")
    let minusButtonView = NSButton()
    let labelView = NSTextField(labelWithString: "2")
    let addButtonView = NSButton()

    var rounds: Int = 2 {
        didSet { labelView.stringValue = "\(rounds)" }
    }

    init() {
        super.init(frame: .zero)
        setup()
        layoutView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setLabel(label: NSTextField) {
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .labelColor
        label.isBordered = false
        label.drawsBackground = false
        label.isSelectable = false
        label.isEditable = false
    }

    private func setup() {
        setLabel(label: titleLabelView)
        setLabel(label: labelView)

        minusButtonView.image = NSImage(systemSymbolName: "minus", accessibilityDescription: nil)
        minusButtonView.isBordered = false
        minusButtonView.target = self
        minusButtonView.action = #selector(minusRoundAction)

        addButtonView.image = NSImage(systemSymbolName: "plus", accessibilityDescription: nil)
        addButtonView.isBordered = false
        addButtonView.target = self
        addButtonView.action = #selector(addRoundAction)
    }

    private func layoutView() {
        addSubview(titleLabelView)
        titleLabelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabelView.topAnchor.constraint(equalTo: topAnchor),
            titleLabelView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabelView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        addSubview(minusButtonView)
        minusButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minusButtonView.leadingAnchor.constraint(equalTo: titleLabelView.trailingAnchor, constant: 12),
            minusButtonView.centerYAnchor.constraint(equalTo: titleLabelView.centerYAnchor),
            minusButtonView.heightAnchor.constraint(equalToConstant: 16),
            minusButtonView.widthAnchor.constraint(equalToConstant: 16)
        ])

        addSubview(labelView)
        labelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelView.leadingAnchor.constraint(equalTo: minusButtonView.trailingAnchor, constant: 4),
            labelView.centerYAnchor.constraint(equalTo: titleLabelView.centerYAnchor),
        ])

        addSubview(addButtonView)
        addButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButtonView.leadingAnchor.constraint(equalTo: labelView.trailingAnchor, constant: 4),
            addButtonView.trailingAnchor.constraint(equalTo: trailingAnchor),
            addButtonView.centerYAnchor.constraint(equalTo: labelView.centerYAnchor),
            addButtonView.heightAnchor.constraint(equalToConstant: 16),
            addButtonView.widthAnchor.constraint(equalToConstant: 16)
        ])
    }
}

extension SetRoundView {
    @objc private func addRoundAction() {
        print("✅ Add")
        rounds = rounds == 9 ? 1 : rounds + 1
    }

    @objc private func minusRoundAction() {
        print("✅ Minus")
        rounds = rounds == 1 ? 9 : rounds - 1
    }
}
