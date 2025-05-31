// Created for Pomodoro in 2025
// Using Swift 6.0
//
//
// Created by HongYan on 2025/5/28.
// Copyright © 2025 HongYan. All rights reserved.


import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: NSWindow!
    var pomodoroStatusBarSetup: PomodoroStatusBarSetup!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Force use dark mode
        NSApp.appearance = NSAppearance(named: .darkAqua)
        // Menu Status Bar Setup
        pomodoroStatusBarSetup = PomodoroStatusBarSetup()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }
}

