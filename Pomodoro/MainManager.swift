// Created for Pomodoro in 2025
// Using Swift 6.0
//
//
// Created by HongYan on 2025/5/29.
// Copyright © 2025 HongYan. All rights reserved.


import Foundation
import AppKit

class MainManager {
    weak var vc: MainViewController?

    var isStart = false

    var totalWorkTime = 0
    var remainWorkTime = 0

    var totalRestTime = 0
    var remainRestTime = 0

    var totalRound = 0
    var currentRound = 0

    private func start() {
        guard let vc else { return }
        totalWorkTime = vc.setWorkTimeView.setHour * 60 * 60 + vc.setWorkTimeView.setMinute * 60
        totalRestTime = vc.setRestTimeView.setMinute * 60
        totalRound = vc.setRoundView.rounds

        currentRound = 0
        Task {
            while currentRound < totalRound {
                remainWorkTime = totalWorkTime
                while 0 < remainWorkTime {
                    let percent = Double(remainWorkTime) / Double(totalWorkTime)
                    await MainActor.run {
                        vc.circleView.progress = percent
                        vc.timeView.hourLabelView.stringValue = String(format: "%02d", remainWorkTime / 3600)
                        vc.timeView.minuteLabelView.stringValue = String(format: "%02d", (remainWorkTime % 3600) / 60)
                        vc.timeView.secondLabelView.stringValue = String(format: "%02d", remainWorkTime % 60)
                    }
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    remainWorkTime -= 1
                    guard isStart else { return }
                }
                remainRestTime = totalRestTime
                while 0 < remainRestTime {
                    let percent = Double(remainRestTime) / Double(totalRestTime)
                    await MainActor.run {
                        vc.circleView.progress = percent
                        vc.timeView.hourLabelView.stringValue = String(format: "%02d", remainRestTime / 3600)
                        vc.timeView.minuteLabelView.stringValue = String(format: "%02d", (remainRestTime % 3600) / 60)
                        vc.timeView.secondLabelView.stringValue = String(format: "%02d", remainRestTime % 60)
                    }
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    remainRestTime -= 1
                    guard isStart else { return }
                }
                currentRound += 1
            }
        }
    }
}

// MARK: - Start Button View Delegate
extension MainManager: StartButtonViewDelegate {
    func startPomodoro() {
        isStart = true
        NSAnimationContext.runAnimationGroup { context in
            context.duration = 0.25
            vc?.setWorkTimeView.animator().alphaValue = 0
            vc?.setRestTimeView.animator().alphaValue = 0
            vc?.setRoundView.animator().alphaValue = 0
            vc?.timeCircleBackground.animator().alphaValue = 0
            vc?.timeView.animator().alphaValue = 1
            vc?.circleView.animator().alphaValue = 1
        } completionHandler: {
            self.start()
        }
        vc?.stopButtonView.isActivate = true
    }
}

// MARK: - Stop Button View Delegate
extension MainManager: StopButtonViewDelegate {
    func stopPomodoro() {
        isStart = false
        NSAnimationContext.runAnimationGroup { context in
            context.duration = 0.25
            vc?.setWorkTimeView.animator().alphaValue = 1
            vc?.setRestTimeView.animator().alphaValue = 1
            vc?.setRoundView.animator().alphaValue = 1
            vc?.timeCircleBackground.animator().alphaValue = 1
            vc?.timeView.animator().alphaValue = 0
            vc?.circleView.animator().alphaValue = 0
        } completionHandler: {
            self.vc?.circleView.progress = 1
        }
        vc?.stopButtonView.isActivate = false
    }
}
