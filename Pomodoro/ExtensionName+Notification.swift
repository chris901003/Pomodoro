// Created for Pomodoro in 2025
// Using Swift 6.0
//
//
// Created by HongYan on 2025/5/30.
// Copyright © 2025 HongYan. All rights reserved.


import Foundation

extension Notification.Name {
    static let setWorkTime = Notification.Name("SetWorkTime")
    static let setRestTime = Notification.Name("SetRestTime")
    static let endPomodoro = Notification.Name("EndPomodoro")
}

class PNotification {
    // MARK: - Set Work Time
    static func sendSetWorkTime(remainTime: Int) {
        NotificationCenter.default.post(name: .setWorkTime, object: nil, userInfo: ["remainWorkTime": remainTime])
    }

    static func decodeSetWorkTime(_ notification: Notification) -> String? {
        guard let userInfo = notification.userInfo,
              let remainWorkTime = userInfo["remainWorkTime"] as? Int else { return nil }
        let hour: String = String(format: "%02d", remainWorkTime / 3600)
        let minute: String = String(format: "%02d", (remainWorkTime % 3600) / 60)
        let second: String = String(format: "%02d", remainWorkTime % 60)
        if remainWorkTime >= 3600 {
            return "\(hour):\(minute):\(second)"
        }
        return "\(minute):\(second)"
    }

    // MARK: - Set Rest Time
    static func sendSetRestTime(remainTime: Int) {
        NotificationCenter.default.post(name: .setRestTime, object: nil, userInfo: ["remainRestTime": remainTime])
    }

    static func decodeSetRestTime(_ notification: Notification) -> String? {
        guard let userInfo = notification.userInfo,
              let remainRestTime = userInfo["remainRestTime"] as? Int else { return nil }
        let minute: String = String(format: "%02d", remainRestTime / 60)
        let second: String = String(format: "%02d", remainRestTime % 60)
        return "\(minute):\(second)"
    }

    // MARK: - End Pomodoro
    static func sendEndPomodoro() {
        NotificationCenter.default.post(name: .endPomodoro, object: nil, userInfo: nil)
    }
}
