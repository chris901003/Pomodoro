// Created for Pomodoro in 2025
// Using Swift 6.0
//
//
// Created by HongYan on 2025/5/29.
// Copyright © 2025 HongYan. All rights reserved.


import Foundation
import AppKit

class SetRestTimeView: NSView {
    let titleLabelView = NSTextField(labelWithString: "休息時長")
    let minuteTextFieldView = NSTextField(labelWithString: "30")

    let addMinuteButtonView = NSButton()
    let minusMinuteButtonView = NSButton()

    var setMinute = 30 {
        didSet {
            minuteTextFieldView.stringValue = (setMinute > 9 ? "" : "0") + "\(setMinute)"
        }
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
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .labelColor
        label.isBordered = false
        label.drawsBackground = false
        label.isSelectable = false
        label.isEditable = false
    }

    private func setup() {
        setLabel(label: titleLabelView)
        setLabel(label: minuteTextFieldView)

        addMinuteButtonView.image = NSImage(systemSymbolName: "chevron.up", accessibilityDescription: nil)
        addMinuteButtonView.isBordered = false
        addMinuteButtonView.target = self
        addMinuteButtonView.action = #selector(tapAddMinuteAction)

        minusMinuteButtonView.image = NSImage(systemSymbolName: "chevron.down", accessibilityDescription: nil)
        minusMinuteButtonView.isBordered = false
        minusMinuteButtonView.target = self
        minusMinuteButtonView.action = #selector(tapMinusMinuteAction)
    }

    private func layoutView() {
        addSubview(titleLabelView)
        titleLabelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabelView.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabelView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        addSubview(minuteTextFieldView)
        minuteTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minuteTextFieldView.leadingAnchor.constraint(equalTo: titleLabelView.trailingAnchor, constant: 12),
            minuteTextFieldView.centerYAnchor.constraint(equalTo: titleLabelView.centerYAnchor),
            minuteTextFieldView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        addSubview(addMinuteButtonView)
        addMinuteButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addMinuteButtonView.bottomAnchor.constraint(equalTo: minuteTextFieldView.topAnchor, constant: 6),
            addMinuteButtonView.centerXAnchor.constraint(equalTo: minuteTextFieldView.centerXAnchor),
            addMinuteButtonView.widthAnchor.constraint(equalToConstant: 25),
            addMinuteButtonView.heightAnchor.constraint(equalToConstant: 25),
            addMinuteButtonView.topAnchor.constraint(equalTo: topAnchor)
        ])

        addSubview(minusMinuteButtonView)
        minusMinuteButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minusMinuteButtonView.topAnchor.constraint(equalTo: minuteTextFieldView.bottomAnchor, constant: -6),
            minusMinuteButtonView.centerXAnchor.constraint(equalTo: minuteTextFieldView.centerXAnchor),
            minusMinuteButtonView.widthAnchor.constraint(equalToConstant: 25),
            minusMinuteButtonView.heightAnchor.constraint(equalToConstant: 25),
            minusMinuteButtonView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension SetRestTimeView {
    @objc private func tapAddMinuteAction() {
        setMinute = setMinute == 59 ? 1 : setMinute + 1
    }

    @objc private func tapMinusMinuteAction() {
        setMinute = setMinute == 1 ? 59 : setMinute - 1
    }
}
