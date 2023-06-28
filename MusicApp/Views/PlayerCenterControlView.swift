//
//  PlayerCenterControlView.swift
//  MusicApp
//
//  Created by Akbarshah Jumanazarov on 5/22/23.
//

import UIKit

protocol PlayerCenterControlViewDelegate: AnyObject {
    func didTapPause()
}

class PlayerCenterControlView: UIView {
    var delegate: PlayerCenterControlViewDelegate?
    
    private let playPauseBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let nextBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "forward.end.alt.fill"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let backBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "backward.end.alt.fill"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private var volumeView: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.backgroundColor = .secondarySystemBackground
        button.layer.masksToBounds = true
        
        button.layer.borderColor = UIColor(named: "greenTint")?.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    private let speakerButton: UIButton = {
        let button = UIButton()
        return button
    }()

    private let dismissBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.tintColor = .lightGray
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addSubview(playPauseBtn)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playPauseBtn.center = center
        playPauseBtn.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
    }
    

    
//    @objc func didTapBackward() {
//        if timeElapsed < 15 {
//            timeElapsed = 0
//            progressView.progress = 0
//        } else {
//            timeElapsed -= 15
//            progressView.progress = Float(timeElapsed/totalTime)
//        }
//        playAt(timeElapsed)
//    }
//
//    @objc func didTapForward() {
//        if timeElapsed > totalTime {
//            resetPlayer()
//        } else {
//            timeElapsed += 15
//            progressView.progress = Float(timeElapsed/totalTime)
//        }
//        playAt(timeElapsed)
//    }
//
//    @objc func didTapBack() {
//        if position > 0 {
//            timeElapsed = 0.0
//            position = position - 1
//            player?.stop()
//            for subview in holder.subviews {
//                subview.removeFromSuperview()
//            }
//            configure()
//        }
//    }
//
//    @objc func didTapPausePlay() {
//        if player?.isPlaying == true {
//            player?.pause()
//            timer.invalidate()
//            playPauseBtn.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
//            //shrink image
//            UIView.animate(withDuration: 0.2) { self.albumImage.frame = CGRect(x: 50,
//                                                                                   y: self.dismissBtn.bottom + 40,
//                                                                                   width: self.holder.width - 100,
//                                                                                   height: self.holder.width - 100)}
//        } else {
//            player?.play()
//            startTimer()
//            playPauseBtn.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
//            //increase image
//            UIView.animate(withDuration: 0.2) { self.albumImage.frame = CGRect(x: 30,
//                                                                                   y: self.dismissBtn.bottom + 20,
//                                                                                   width: self.holder.width - 60,
//                                                                                   height: self.holder.width - 60)}
//        }
//    }
}
