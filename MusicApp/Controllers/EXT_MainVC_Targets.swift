//
//  EXT_MainVC.swift
//  MusicApp
//
//  Created by Akbarshah Jumanazarov on 4/16/23.
//

import UIKit

extension MainViewController {
    
    @objc func didTapPlayPause() {
        if player?.isPlaying == true {
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            player?.pause()
            timer.invalidate()
        } else {
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            player?.play()
            startTimer()
        }
    }
    
    @objc func didTapNext() {
        if position < (songs.count - 1) {
            timeElapsed = 0.0
            position = position + 1
            player?.stop()
            configure()
        }
    }
    
    @objc func didTapBack() {
        if position > 0 {
            timeElapsed = 0.0
            position = position - 1
            player?.stop()
            configure()
        }
    }
}
