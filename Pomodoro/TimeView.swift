// Created for Pomodoro in 2025
// Using Swift 6.0
//
//
// Created by HongYan on 2025/5/29.
// Copyright © 2025 HongYan. All rights reserved.


import Foundation
import AppKit

class TimeView: NSView {
    let hourLabelView = NSTextField()
    let sepLabelView = NSTextField()
    let minuteLabelView = NSTextField()
    let secondLabelView = NSTextField()

    init() {
        super.init(frame: .zero)
        setup()
        layoutView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        hourLabelView.stringValue = "00"
        hourLabelView.font = .systemFont(ofSize: 55, weight: .semibold)
        hourLabelView.textColor = .white
        hourLabelView.isBordered = false
        hourLabelView.drawsBackground = false
        hourLabelView.isSelectable = false
        hourLabelView.isEditable = false

        sepLabelView.stringValue = ":"
        sepLabelView.font = .systemFont(ofSize: 55, weight: .semibold)
        sepLabelView.textColor = .white
        sepLabelView.isBordered = false
        sepLabelView.drawsBackground = false
        sepLabelView.isSelectable = false
        sepLabelView.isEditable = false

        minuteLabelView.stringValue = "00"
        minuteLabelView.font = .systemFont(ofSize: 55, weight: .semibold)
        minuteLabelView.textColor = .white
        minuteLabelView.isBordered = false
        minuteLabelView.drawsBackground = false
        minuteLabelView.isSelectable = false
        minuteLabelView.isEditable = false

        secondLabelView.stringValue = "00"
        secondLabelView.font = .systemFont(ofSize: 25, weight: .semibold)
        secondLabelView.textColor = .systemGray
        secondLabelView.isBordered = false
        secondLabelView.drawsBackground = false
        secondLabelView.isSelectable = false
        secondLabelView.isEditable = false
    }

    private func layoutView() {
        addSubview(hourLabelView)
        hourLabelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hourLabelView.leadingAnchor.constraint(equalTo: leadingAnchor),
            hourLabelView.topAnchor.constraint(equalTo: topAnchor),
            hourLabelView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        addSubview(sepLabelView)
        sepLabelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sepLabelView.leadingAnchor.constraint(equalTo: hourLabelView.trailingAnchor, constant: 4),
            sepLabelView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -4)
        ])

        addSubview(minuteLabelView)
        minuteLabelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            minuteLabelView.leadingAnchor.constraint(equalTo: sepLabelView.trailingAnchor, constant: 4),
            minuteLabelView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])

        addSubview(secondLabelView)
        secondLabelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondLabelView.leadingAnchor.constraint(equalTo: minuteLabelView.trailingAnchor, constant: 4),
            secondLabelView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            secondLabelView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
