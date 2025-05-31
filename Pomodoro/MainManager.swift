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
                await MainActor.run {
                    vc.roundCountLabelView.stringValue = "第 \(currentRound + 1) / \(totalRound) 回合 (工作中)"
                }
                remainWorkTime = totalWorkTime
                while 0 < remainWorkTime {
                    if remainWorkTime == 3 {
                        if let url = Bundle.main.url(forResource: "End", withExtension: "mp3"),
                           let sound = NSSound(contentsOf: url, byReference: false) {
                            sound.play()
                        }
                    }
                    let percent = Double(remainWorkTime) / Double(totalWorkTime)
                    await MainActor.run {
                        vc.circleView.progress = percent
                        vc.timeView.hourLabelView.stringValue = String(format: "%02d", remainWorkTime / 3600)
                        vc.timeView.minuteLabelView.stringValue = String(format: "%02d", (remainWorkTime % 3600) / 60)
                        vc.timeView.secondLabelView.stringValue = String(format: "%02d", remainWorkTime % 60)
                        PNotification.sendSetWorkTime(remainTime: remainWorkTime)
                    }
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    remainWorkTime -= 1
                    guard isStart else { return }
                }
                await MainActor.run {
                    vc.roundCountLabelView.stringValue = "第 \(currentRound + 1) / \(totalRound) 回合 (休息中)"
                }
                remainRestTime = totalRestTime
                while 0 < remainRestTime {
                    if remainRestTime == 3 {
                        if let url = Bundle.main.url(forResource: "Start", withExtension: "mp3"),
                           let sound = NSSound(contentsOf: url, byReference: false) {
                            sound.play()
                        }
                    }
                    let percent = Double(remainRestTime) / Double(totalRestTime)
                    await MainActor.run {
                        vc.circleView.progress = percent
                        vc.timeView.hourLabelView.stringValue = String(format: "%02d", remainRestTime / 3600)
                        vc.timeView.minuteLabelView.stringValue = String(format: "%02d", (remainRestTime % 3600) / 60)
                        vc.timeView.secondLabelView.stringValue = String(format: "%02d", remainRestTime % 60)
                        PNotification.sendSetRestTime(remainTime: remainRestTime)
                    }
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    remainRestTime -= 1
                    guard isStart else { return }
                }
                currentRound += 1
            }
            await MainActor.run { stopPomodoro() }
        }
    }
}

// MARK: - Start Button View Delegate
extension MainManager: StartButtonViewDelegate {
    func startPomodoro() {
        vc?.startButtonView.isActivate = false
        isStart = true
        NSAnimationContext.runAnimationGroup { context in
            context.duration = 0.25
            vc?.setWorkTimeView.animator().alphaValue = 0
            vc?.setRestTimeView.animator().alphaValue = 0
            vc?.setRoundView.animator().alphaValue = 0
            vc?.timeCircleBackground.animator().alphaValue = 0
        } completionHandler: {
            self.vc?.countDownView.startCountDown(value: 3)
            if let url = Bundle.main.url(forResource: "Begin", withExtension: "mp3"),
               let sound = NSSound(contentsOf: url, byReference: false) {
                sound.play()
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self else { return }
            NSAnimationContext.runAnimationGroup { [weak self] context in
                guard let self else { return }
                context.duration = 0.25
                vc?.timeView.animator().alphaValue = 1
                vc?.circleView.animator().alphaValue = 1
                vc?.roundCountLabelView.animator().alphaValue = 1
            } completionHandler: {
                self.start()
            }
            vc?.stopButtonView.isActivate = true
        }
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
            vc?.roundCountLabelView.animator().alphaValue = 0
        } completionHandler: {
            self.vc?.circleView.progress = 1
        }
        vc?.startButtonView.isActivate = true
        vc?.stopButtonView.isActivate = false
        vc?.roundCountLabelView.stringValue = ""
        PNotification.sendEndPomodoro()
    }
}
