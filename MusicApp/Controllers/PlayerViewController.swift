//
//  PlayerViewController.swift
//  MusicApp
//
//  Created by Akbarshah Jumanazarov on 3/23/23.
//

import UIKit
import AVFoundation
import Hero

class PlayerViewController: UIViewController {
    
    public var position: Int
    public var songs: [SongModel]
    
    init(position: Int, songs: [SongModel]) {
        self.position = position
        self.songs = songs
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var player: AVAudioPlayer?
    var timer = Timer()
    
    var totalTime: Double = 0.0
    var timeElapsed: Double = 0.0
    var volume: Float = 0.5
    var isPlaying: Bool = false
    var completion: ((Int, Double, Float, Bool) -> Void)?
        
    private let holder: UIView = {
        let view = UIView()
        return view
    }()
    
    
    
    
    
    let albumImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 15
        return image
    }()
    
    let songLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .heavy)
        return label
    }()
    
    let artistLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    let albumLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    private var progressView: UIProgressView = {
        let bar = UIProgressView()
        bar.tintColor = UIColor(named: "greenTint")
        bar.progress = 0.0
        return bar
    }()
    
    private let timeCount: UILabel = {
        let label = UILabel()
        label.text = "0:00"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private let timeLeft: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        holder.backgroundColor = .clear
        blur(view, style: .prominent)
        view.addSubview(holder)
        holder.frame = view.bounds
        if holder.subviews.count == 0 {
            configure()
        }
        startTimer()
        progressView.progress = Float(timeElapsed/totalTime)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view?.hero.isEnabled = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if player?.isPlaying == true {
            isPlaying = true
        } else {
            isPlaying = false
        }
        completion?(position, timeElapsed, volume, isPlaying)
        player?.stop()
        view?.hero.isEnabled = false
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dismissBtn.frame = CGRect(x: holder.width/2 - 25, y: 10, width: 50, height: 20)
        albumImage.frame = CGRect(x: 30, y: dismissBtn.bottom + 20, width: holder.width - 60, height: holder.width - 60)
        albumLabel.frame = CGRect(x: 10, y: albumImage.bottom + 20, width: holder.width - 20, height: 17)
        songLabel.frame = CGRect(x: 10, y: albumLabel.bottom, width: holder.width - 20, height: 26)
        artistLabel.frame = CGRect(x: 10, y: songLabel.bottom, width: holder.width - 20, height: 17)
        progressView.frame = CGRect(x: 20, y: artistLabel.bottom + 20, width: holder.width - 40, height: 30)
        timeCount.frame = CGRect(x: 20, y: progressView.top + 10, width: 35, height: 12)
        playPauseBtn.frame = CGRect(x: holder.width/2 - 20, y: progressView.bottom + 20, width: 40, height: 40)
        nextBtn.frame = CGRect(x: playPauseBtn.right + 20, y: progressView.bottom + 20 + 10, width: 40, height: 20)
        backBtn.frame = CGRect(x: playPauseBtn.left - 20 - 40, y: progressView.bottom + 20 + 10, width: 40, height: 20)
        timeLeft.frame = CGRect(x: holder.width - 55, y: progressView.top + 10, width: 35, height: 12)
        speakerButton = CGRect(x: likeButton.right + 2*30, y: playPauseBtn.bottom + 30, width: 26, height: 20)
        volumeView = CGRect(x: 30, y: speakerButton.bottom + 15, width: holder.width - 60, height: 40)
    }
    
    func configure() {
        
        
        dismissBtn.addTarget(self, action: #selector(didTapDismiss), for: .touchUpInside)
        holder.addSubview(dismissBtn)
        
        holder.addSubview(albumImage)
        
        holder.addSubview(songLabel)
        holder.addSubview(albumLabel)
        holder.addSubview(artistLabel)
        
        playPauseBtn.addTarget(self, action: #selector(didTapPausePlay), for: .touchUpInside)
        nextBtn.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        backBtn.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)

        holder.addSubview(progressView)
        holder.addSubview(timeCount)
        
        if totalTime < 10 {
            timeLeft.text = "-0:0\(timeFormatter(interval: totalTime))"
        } else if totalTime < 60 {
            timeLeft.text = "-0:\(timeFormatter(interval: totalTime))"
        } else {
            timeLeft.text = "-\(timeFormatter(interval: totalTime))"
        }
        
        holder.addSubview(timeLeft)

        let forward = UIButton(frame: CGRect(x: nextBtn.right + 15, y: progressView.bottom + 20 + 5, width: 30, height: 30))
        forward.setBackgroundImage(UIImage(systemName: "goforward.15"), for: .normal)
        forward.addTarget(self, action: #selector(didTapForward), for: .touchUpInside)
        
        let backward = UIButton(frame: CGRect(x: backBtn.left - 30 - 15, y: progressView.bottom + 20 + 5, width: 30, height: 30))
        backward.setBackgroundImage(UIImage(systemName: "gobackward.15"), for: .normal)
        backward.addTarget(self, action: #selector(didTapBackward), for: .touchUpInside)
        
        forward.tintColor = .label
        backward.tintColor = .label
        
        holder.addSubview(playPauseBtn)
        holder.addSubview(nextBtn)
        holder.addSubview(backBtn)
        holder.addSubview(forward)
        holder.addSubview(backward)
        
        let loopButton = UIButton(frame: CGRect(x: holder.width/2 - 30 - 26, y: playPauseBtn.bottom + 30, width: 26, height: 20))
        let shuffleButton = UIButton(frame: CGRect(x: loopButton.left - 2*30 - 26, y: playPauseBtn.bottom + 30, width: 26, height: 20))

        let likeButton = UIButton(frame: CGRect(x: holder.width/2 + 30, y: playPauseBtn.bottom + 30, width: 26, height: 20))
        
        shuffleButton.setBackgroundImage(UIImage(systemName: "shuffle"), for: .normal)
        likeButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        loopButton.setBackgroundImage(UIImage(systemName: "repeat"), for: .normal)
        speakerButton.setBackgroundImage(UIImage(systemName: "speaker.wave.1"), for: .normal)
        
        shuffleButton.tintColor = .label
        likeButton.tintColor = .label
        loopButton.tintColor = .label
        speakerButton.tintColor = .label
        
        speakerButton.addTarget(self, action: #selector(didTapSpeaker), for: .touchUpInside)
        
        holder.addSubview(shuffleButton)
        holder.addSubview(likeButton)
        holder.addSubview(loopButton)
        holder.addSubview(speakerButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
       {
           let touch = touches.first
           if touch?.view != self.volumeView {
               volumeView.isHidden = true
               speakerButton.setBackgroundImage(UIImage(systemName: "speaker.wave.1"), for: .normal)
           }
       }
    
    func resetPlayer() {
        player?.stop()
        timer.invalidate()
        timeElapsed = 0
        progressView.progress = 0
        timeCount.text = "0:00"
        timeLeft.text = "-\(timeFormatter(interval: totalTime))"
        playPauseBtn.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
        //shrink image
        UIView.animate(withDuration: 0.2) { self.albumImage.frame = CGRect(x: 50,
                                                                               y: self.dismissBtn.bottom + 40,
                                                                               width: self.holder.width - 100,
                                                                               height: self.holder.width - 100)}
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerCount), userInfo: nil, repeats: true)
    }
    
    ///Plays audio at a specific time
    func playAt(_ time: Double) {
        let shortStartDelay: TimeInterval = 0.05 // seconds
        let now: TimeInterval = player?.deviceCurrentTime ?? 0
        let timeDelayPlay: TimeInterval = now + shortStartDelay
        player?.currentTime = time // Specific time to start play
        player?.play(atTime: timeDelayPlay)
    }
}

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
