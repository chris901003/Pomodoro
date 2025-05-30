// Created for Pomodoro in 2025
// Using Swift 6.0
//
//
// Created by HongYan on 2025/5/28.
// Copyright © 2025 HongYan. All rights reserved.


import Cocoa

//@main
class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    var statusItem: NSStatusItem!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Window Setup
        let windowSize = NSMakeRect(0, 0, 800, 600)

        window = NSWindow(
            contentRect: windowSize,
            styleMask: [.titled, .closable, .resizable, .miniaturizable],
            backing: .buffered,
            defer: false
        )

        window.center()
        window.title = "Pomodoro"
        window.makeKeyAndOrderFront(nil)
        window.contentViewController = MainViewController()

        // Menu Status Bar Setup
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
        }
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}

