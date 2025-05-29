// Created for Pomodoro in 2025
// Using Swift 6.0
//
//
// Created by HongYan on 2025/5/29.
// Copyright © 2025 HongYan. All rights reserved.


import Foundation
import AppKit

class SetWorkTimeView: NSView {
    let titleLabelView = NSTextField(labelWithString: "工作時長")
    let hourTextFieldView = NSTextField(labelWithString: "00")
    let sepTextFieldView = NSTextField(labelWithString: ":")
    let minuteTextFieldView = NSTextField(labelWithString: "30")

    let addHourButtonView = NSButton()
    let minusHourButtonView = NSButton()

    let addMinuteButtonView = NSButton()
    let minusMinuteButtonView = NSButton()

    var setHour = 0 {
        didSet {
            hourTextFieldView.stringValue = (setHour > 9 ? "" : "0") + "\(setHour)"
        }
    }
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
        setLabel(label: hourTextFieldView)
        setLabel(label: sepTextFieldView)
        setLabel(label: minuteTextFieldView)

        addHourButtonView.image = NSImage(systemSymbolName: "chevron.up", accessibilityDescription: nil)
        addHourButtonView.isBordered = false
        addHourButtonView.target = self
        addHourButtonView.action = #selector(tapAddHourAction)

        minusHourButtonView.image = NSImage(systemSymbolName: "chevron.down", accessibilityDescription: nil)
        minusHourButtonView.isBordered = false
        minusHourButtonView.target = self
        minusHourButtonView.action = #selector(tapMinusHourAction)

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

        addSubview(hourTextFieldView)
        hourTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hourTextFieldView.leadingAnchor.constraint(equalTo: titleLabelView.trailingAnchor, constant: 12),
            hourTextFieldView.centerYAnchor.constraint(equalTo: titleLabelView.centerYAnchor)
        ])

        addSubview(addHourButtonView)
        addHourButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addHourButtonView.bottomAnchor.constraint(equalTo: hourTextFieldView.topAnchor, constant: 6),
            addHourButtonView.centerXAnchor.constraint(equalTo: hourTextFieldView.centerXAnchor),
            addHourButtonView.topAnchor.constraint(equalTo: topAnchor),
            addHourButtonView.widthAnchor.constraint(equalToConstant: 25),
            addHourButtonView.heightAnchor.constraint(equalToConstant: 25)
        ])

        addSubview(minusHourButtonView)
        minusHourButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minusHourButtonView.topAnchor.constraint(equalTo: hourTextFieldView.bottomAnchor, constant: -6),
            minusHourButtonView.centerXAnchor.constraint(equalTo: hourTextFieldView.centerXAnchor),
            minusHourButtonView.bottomAnchor.constraint(equalTo: bottomAnchor),
            minusHourButtonView.widthAnchor.constraint(equalToConstant: 25),
            minusHourButtonView.heightAnchor.constraint(equalToConstant: 25)
        ])

        addSubview(sepTextFieldView)
        sepTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sepTextFieldView.leadingAnchor.constraint(equalTo: hourTextFieldView.trailingAnchor, constant: 4),
            sepTextFieldView.centerYAnchor.constraint(equalTo: hourTextFieldView.centerYAnchor, constant: -1)
        ])

        addSubview(minuteTextFieldView)
        minuteTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minuteTextFieldView.leadingAnchor.constraint(equalTo: sepTextFieldView.trailingAnchor, constant: 4),
            minuteTextFieldView.centerYAnchor.constraint(equalTo: hourTextFieldView.centerYAnchor),
            minuteTextFieldView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        addSubview(addMinuteButtonView)
        addMinuteButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addMinuteButtonView.bottomAnchor.constraint(equalTo: minuteTextFieldView.topAnchor, constant: 6),
            addMinuteButtonView.centerXAnchor.constraint(equalTo: minuteTextFieldView.centerXAnchor),
            addMinuteButtonView.widthAnchor.constraint(equalToConstant: 25),
            addMinuteButtonView.heightAnchor.constraint(equalToConstant: 25)
        ])

        addSubview(minusMinuteButtonView)
        minusMinuteButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minusMinuteButtonView.topAnchor.constraint(equalTo: minuteTextFieldView.bottomAnchor, constant: -6),
            minusMinuteButtonView.centerXAnchor.constraint(equalTo: minuteTextFieldView.centerXAnchor),
            minusMinuteButtonView.widthAnchor.constraint(equalToConstant: 25),
            minusMinuteButtonView.heightAnchor.constraint(equalToConstant: 25)
        ])
    }
}

extension SetWorkTimeView {
    @objc private func tapAddHourAction() {
        setHour = setHour == 23 ? 0 : setHour + 1
    }

    @objc private func tapMinusHourAction() {
        setHour = setHour == 0 ? 23 : setHour - 1
    }

    @objc private func tapAddMinuteAction() {
        setMinute = setMinute == 59 ? 0 : setMinute + 1
    }

    @objc private func tapMinusMinuteAction() {
        setMinute = setMinute == 0 ? 59 : setMinute - 1
    }
}
