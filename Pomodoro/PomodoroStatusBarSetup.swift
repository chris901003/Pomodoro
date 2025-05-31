// Created for Pomodoro in 2025
// Using Swift 6.0
//
//
// Created by HongYan on 2025/5/31.
// Copyright © 2025 HongYan. All rights reserved.


import Foundation
import AppKit

class PomodoroStatusBarSetup {
    var statusItem: NSStatusItem!
    var panel: NSPanel!

    init() {
        setupStatusBarView()
        setupStatusBarPanel()
    }

    private func setupStatusBarView() {
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem.button {
            let menuStatusBarIconView = MenuStatusBarIconView()
            button.addSubview(menuStatusBarIconView)
            menuStatusBarIconView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                menuStatusBarIconView.heightAnchor.constraint(equalToConstant: 22),
                menuStatusBarIconView.leadingAnchor.constraint(equalTo: button.leadingAnchor),
                menuStatusBarIconView.trailingAnchor.constraint(equalTo: button.trailingAnchor),
                menuStatusBarIconView.centerYAnchor.constraint(equalTo: button.centerYAnchor)
            ])

            button.target = self
            button.action = #selector(togglePanel)
        }
    }

    private func setupStatusBarPanel() {
        let panelWidth: CGFloat = 800
        let panelHeight: CGFloat = 600
        panel = NSPanel(
            contentRect: .init(x: 0, y: 0, width: panelWidth, height: panelHeight),
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )

        panel.isFloatingPanel = true
        panel.level = .floating
        panel.hasShadow = true
        panel.isMovableByWindowBackground = false
        panel.title = "Pomodoro"
        panel.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        panel.backgroundColor = .clear
        panel.isReleasedWhenClosed = false
        panel.hidesOnDeactivate = true

        let viewController = MainViewController()
        panel.contentViewController = viewController
    }

    @objc private func togglePanel() {
        guard let button = statusItem.button else { return }

        if panel.isVisible {
            panel.orderOut(nil)
        } else {
            if let window = button.window {
                let buttonFrame = button.convert(button.bounds, to: nil)
                let screenRect = window.convertToScreen(buttonFrame)
                let panelOrigin = CGPoint(
                    x: screenRect.origin.x - (panel.frame.width / 2) + (screenRect.width / 2),
                    y: screenRect.origin.y - panel.frame.height - 10
                )
                panel.setFrameOrigin(panelOrigin)
            }

            NSApp.activate(ignoringOtherApps: true)
            panel.orderFront(nil)
        }
    }
}
