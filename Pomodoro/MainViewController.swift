// Created for Pomodoro in 2025
// Using Swift 6.0
//
//
// Created by HongYan on 2025/5/28.
// Copyright © 2025 HongYan. All rights reserved.


import Foundation
import Cocoa

class MainViewController: NSViewController {
    let titleLabel = NSTextField()
    let timeCircleBackground = NSView()
    let circleView = GradientCircleProgressView()

    let timeView = TimeView()
    let roundCountLabelView = NSTextField()

    let countDownView = CountDownView()

    let setWorkTimeView = SetWorkTimeView()
    let setRestTimeView = SetRestTimeView()
    let setRoundView = SetRoundView()

    let startButtonView = StartButtonView()
    let stopButtonView = StopButtonView()

    let manager = MainManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }

    private func setup() {
        manager.vc = self

        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.windowBackgroundColor.cgColor

        titleLabel.stringValue = "Pomodoro"
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.maximumNumberOfLines = 1
        titleLabel.alignment = .center
        titleLabel.isBordered = false
        titleLabel.drawsBackground = false
        titleLabel.isSelectable = false
        titleLabel.isEditable = false

        timeCircleBackground.wantsLayer = true
        timeCircleBackground.layer?.cornerRadius = 200
        timeCircleBackground.layer?.borderWidth = 5.0
        timeCircleBackground.layer?.borderColor = NSColor.controlBackgroundColor.cgColor

        circleView.alphaValue = 0

        timeView.alphaValue = 0

        roundCountLabelView.alphaValue = 0
        roundCountLabelView.font = .systemFont(ofSize: 14, weight: .bold)
        roundCountLabelView.textColor = .labelColor
        roundCountLabelView.isBordered = false
        roundCountLabelView.drawsBackground = false
        roundCountLabelView.isSelectable = false
        roundCountLabelView.isEditable = false

        startButtonView.delegate = manager
        stopButtonView.delegate = manager
    }

    private func layout() {
        view.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12)
        ])

        view.addSubview(timeCircleBackground)
        timeCircleBackground.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeCircleBackground.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            timeCircleBackground.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timeCircleBackground.widthAnchor.constraint(equalToConstant: 400),
            timeCircleBackground.heightAnchor.constraint(equalToConstant: 400)
        ])

        view.addSubview(circleView)
        circleView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            circleView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 400),
            circleView.heightAnchor.constraint(equalToConstant: 400)
        ])

        view.addSubview(timeView)
        timeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timeView.centerXAnchor.constraint(equalTo: timeCircleBackground.centerXAnchor),
            timeView.centerYAnchor.constraint(equalTo: timeCircleBackground.centerYAnchor)
        ])

        view.addSubview(roundCountLabelView)
        roundCountLabelView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            roundCountLabelView.bottomAnchor.constraint(equalTo: timeCircleBackground.bottomAnchor, constant: -72),
            roundCountLabelView.centerXAnchor.constraint(equalTo: timeCircleBackground.centerXAnchor)
        ])

        view.addSubview(countDownView)
        countDownView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            countDownView.centerXAnchor.constraint(equalTo: timeCircleBackground.centerXAnchor),
            countDownView.centerYAnchor.constraint(equalTo: timeCircleBackground.centerYAnchor)
        ])

        view.addSubview(setWorkTimeView)
        setWorkTimeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setWorkTimeView.centerXAnchor.constraint(equalTo: timeCircleBackground.centerXAnchor),
            setWorkTimeView.bottomAnchor.constraint(equalTo: timeCircleBackground.centerYAnchor, constant: -12)
        ])

        view.addSubview(setRestTimeView)
        setRestTimeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setRestTimeView.centerXAnchor.constraint(equalTo: timeCircleBackground.centerXAnchor),
            setRestTimeView.topAnchor.constraint(equalTo: timeCircleBackground.centerYAnchor, constant: 12)
        ])

        view.addSubview(setRoundView)
        setRoundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            setRoundView.topAnchor.constraint(equalTo: setRestTimeView.bottomAnchor, constant: 36),
            setRoundView.centerXAnchor.constraint(equalTo: timeCircleBackground.centerXAnchor)
        ])

        view.addSubview(startButtonView)
        startButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startButtonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
            startButtonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12)
        ])

        view.addSubview(stopButtonView)
        stopButtonView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stopButtonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            stopButtonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12)
        ])
    }
}
