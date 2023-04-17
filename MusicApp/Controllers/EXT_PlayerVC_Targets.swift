//
//  EXT_PlayerVC_Targets.swift
//  MusicApp
//
//  Created by Akbarshah Jumanazarov on 4/16/23.
//

import UIKit

extension PlayerViewController {
    
    @objc func timerCount() {
        if timeElapsed != totalTime && timeElapsed < totalTime {
            timeElapsed += 1
            progressView.progress = Float(timeElapsed/totalTime)
            
            if timeElapsed < 10 {
                timeCount.text = "0:0\(timeFormatter(interval: timeElapsed))"
            } else if timeElapsed <= 59 {
                timeCount.text = "0:\(timeFormatter(interval: timeElapsed))"
            } else {
                timeCount.text = timeFormatter(interval: timeElapsed)
            }
            
            if totalTime - timeElapsed < 10 {
                timeLeft.text = "-0:0\(timeFormatter(interval: totalTime - timeElapsed))"
            } else if totalTime - timeElapsed < 60 {
                timeLeft.text = "-0:\(timeFormatter(interval: totalTime - timeElapsed))"
            } else {
                timeLeft.text = "-\(timeFormatter(interval: totalTime - timeElapsed))"
            }
        } else {
            resetPlayer()
        }
    }
    
    @objc func didTapSpeaker() {
        speakerButton.setBackgroundImage(UIImage(systemName: "speaker.wave.1.fill"), for: .normal)
        volumeView.isHidden = false
    }
    
    @objc func didTapForward() {
        if timeElapsed > totalTime {
            resetPlayer()
        } else {
            timeElapsed += 15
            progressView.progress = Float(timeElapsed/totalTime)
        }
        playAt(timeElapsed)
    }
    
    @objc func didTapBackward() {
        if timeElapsed < 15 {
            timeElapsed = 0
            progressView.progress = 0
        } else {
            timeElapsed -= 15
            progressView.progress = Float(timeElapsed/totalTime)
        }
        playAt(timeElapsed)
    }
    
    @objc func didTapDismiss() {
        self.dismiss(animated: true)
    }
    
    @objc func didTapBack() {
        if position > 0 {
            timeElapsed = 0.0
            position = position - 1
            player?.stop()
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    @objc func didTapNext() {
        if position < (songs.count - 1) {
            timeElapsed = 0.0
            position = position + 1
            player?.stop()
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    @objc func didTapPausePlay() {
        if player?.isPlaying == true {
            player?.pause()
            timer.invalidate()
            playPauseBtn.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            //shrink image
            UIView.animate(withDuration: 0.2) { self.albumImage.frame = CGRect(x: 50,
                                                                                   y: self.dismissBtn.bottom + 40,
                                                                                   width: self.holder.width - 100,
                                                                                   height: self.holder.width - 100)}
        } else {
            player?.play()
            startTimer()
            playPauseBtn.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            //increase image
            UIView.animate(withDuration: 0.2) { self.albumImage.frame = CGRect(x: 30,
                                                                                   y: self.dismissBtn.bottom + 20,
                                                                                   width: self.holder.width - 60,
                                                                                   height: self.holder.width - 60)}
        }
    }
    
    @objc func didSlideSlider(_ slider: UISlider) {
        volume = slider.value
        player?.volume = volume
    }
}
