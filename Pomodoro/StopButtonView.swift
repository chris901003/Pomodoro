// Created for Pomodoro in 2025
// Using Swift 6.0
//
//
// Created by HongYan on 2025/5/29.
// Copyright © 2025 HongYan. All rights reserved.


import Foundation
import Cocoa

class StopButtonView: NSView {
    let circleView = NSView()
    let labelView = NSTextField()

    var isActivate: Bool = false

    init() {
        super.init(frame: .zero)
        setup()
        layoutView()
        addTracker()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        circleView.wantsLayer = true
        circleView.layer?.cornerRadius = 40
        circleView.layer?.borderWidth = 2.0
        circleView.layer?.borderColor = NSColor.controlBackgroundColor.cgColor

        labelView.stringValue = "Stop"
        labelView.font = .systemFont(ofSize: 14, weight: .bold)
        labelView.textColor = .controlBackgroundColor
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

    private func addTracker() {
        let options: NSTrackingArea.Options = [
            .mouseEnteredAndExited, .activeAlways, .inVisibleRect
        ]

        let trackingArea = NSTrackingArea(
            rect: circleView.bounds,
            options: options,
            owner: self,
            userInfo: ["id": "start-circle-view"]
        )
        circleView.addTrackingArea(trackingArea)
    }

    override func mouseEntered(with event: NSEvent) {
        guard isActivate else { return }
        circleView.layer?.backgroundColor = NSColor.systemRed.cgColor
        labelView.textColor = .white
    }

    override func mouseExited(with event: NSEvent) {
        guard isActivate else { return }
        circleView.layer?.backgroundColor = .clear
        labelView.textColor = .systemRed
    }

    override func mouseDown(with event: NSEvent) {
        guard isActivate else { return }
        let locationInView = convert(event.locationInWindow, from: nil)
        if circleView.frame.contains(locationInView) {
            print("✅ Mouse down")
            circleView.layer?.backgroundColor = .clear
            labelView.textColor = .systemRed
        }
    }

    override func mouseUp(with event: NSEvent) {
        guard isActivate else { return }
        let locationInView = convert(event.locationInWindow, from: nil)
        if circleView.frame.contains(locationInView) {
            print("✅ Mouse up")
            circleView.layer?.backgroundColor = NSColor.systemRed.cgColor
            labelView.textColor = .white
        }
    }
}
