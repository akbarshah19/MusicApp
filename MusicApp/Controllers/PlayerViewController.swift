//
//  PlayerViewController.swift
//  MusicApp
//
//  Created by Akbarshah Jumanazarov on 3/23/23.
//

import UIKit
class PlayerViewController: UIViewController {
    
    
    public var position: Int = 0
    public var songs: [SongModel]
    
    init(position: Int, songs: [SongModel]) {
        self.position = position
        self.songs = songs
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let backgroundImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var centerControl = PlayerCenterControlView()
    
    var totalTime: Double = 0.0
    var timeElapsed: Double = 0.0
    var volume: Float = 0.5
    var isPlaying: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        addSubviews()
        blur(containerView, style: .regular)
        centerControl.delegate = self
    }
    
    private func addSubviews() {
        view.addSubview(backgroundImage)
        backgroundImage.addSubview(containerView)
        containerView.addSubview(centerControl)
    }
    
    private func setup() {
        backgroundImage.image = UIImage(named: songs[position].imageName)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.frame = view.bounds
        backgroundImage.frame = containerView.bounds
        centerControl.frame = CGRect(x: 0, y: 0, width: containerView.width, height: 100)
        centerControl.center.y = view.center.y
    }
}

extension PlayerViewController: PlayerCenterControlViewDelegate {
    func didTapPause() {
        
    }
}
           
//    let albumImage: UIImageView = {
//        let image = UIImageView()
//        image.contentMode = .scaleAspectFill
//        image.layer.masksToBounds = true
//        image.layer.cornerRadius = 15
//        return image
//    }()
//    
//    let songLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        label.font = .systemFont(ofSize: 24, weight: .heavy)
//        return label
//    }()
//    
//    let artistLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        label.font = .systemFont(ofSize: 15, weight: .regular)
//        return label
//    }()
//    
//    let albumLabel: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .center
//        label.numberOfLines = 0
//        label.font = .systemFont(ofSize: 15, weight: .regular)
//        return label
//    }()
//    
//    private var progressView: UIProgressView = {
//        let bar = UIProgressView()
//        bar.tintColor = UIColor(named: "greenTint")
//        bar.progress = 0.0
//        return bar
//    }()
//    
//    private let timeCount: UILabel = {
//        let label = UILabel()
//        label.text = "0:00"
//        label.font = .systemFont(ofSize: 12, weight: .regular)
//        return label
//    }()
//    
//    private let timeLeft: UILabel = {
//        let label = UILabel()
//        label.textAlignment = .right
//        label.font = .systemFont(ofSize: 12, weight: .regular)
//        return label
//    }()
//    
//    var timer = Timer()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .clear
//        holder.backgroundColor = .clear
//        blur(view, style: .prominent)
//        view.addSubview(holder)
//        holder.frame = view.bounds
//        if holder.subviews.count == 0 {
//            configure()
//        }
//        startTimer()
//        progressView.progress = Float(timeElapsed/totalTime)
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        view?.hero.isEnabled = true
//    }
//    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        if player?.isPlaying == true {
//            isPlaying = true
//        } else {
//            isPlaying = false
//        }
//        completion?(position, timeElapsed, volume, isPlaying)
//        player?.stop()
//        view?.hero.isEnabled = false
//    }
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        
//    }
//    
//    func configure() {
//        holder.addSubview(albumImage)
//        
//        if totalTime < 10 {
//            timeLeft.text = "-0:0\(timeFormatter(interval: totalTime))"
//        } else if totalTime < 60 {
//            timeLeft.text = "-0:\(timeFormatter(interval: totalTime))"
//        } else {
//            timeLeft.text = "-\(timeFormatter(interval: totalTime))"
//        }
//    }
//    
////    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
////       {
////           let touch = touches.first
////           if touch?.view != self.volumeView {
////               volumeView.isHidden = true
////               speakerButton.setBackgroundImage(UIImage(systemName: "speaker.wave.1"), for: .normal)
////           }
////       }
//    
////    func resetPlayer() {
////        player?.stop()
////        timer.invalidate()
////        timeElapsed = 0
////        progressView.progress = 0
////        timeCount.text = "0:00"
////        timeLeft.text = "-\(timeFormatter(interval: totalTime))"
////        playPauseBtn.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
////        //shrink image
////        UIView.animate(withDuration: 0.2) { self.albumImage.frame = CGRect(x: 50,
////                                                                               y: self.dismissBtn.bottom + 40,
////                                                                               width: self.holder.width - 100,
////                                                                               height: self.holder.width - 100)}
////    }
//    
////    func startTimer() {
////        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerCount), userInfo: nil, repeats: true)
////    }
//    
////    ///Plays audio at a specific time
////    func playAt(_ time: Double) {
////        let shortStartDelay: TimeInterval = 0.05 // seconds
////        let now: TimeInterval = player?.deviceCurrentTime ?? 0
////        let timeDelayPlay: TimeInterval = now + shortStartDelay
////        player?.currentTime = time // Specific time to start play
////        player?.play(atTime: timeDelayPlay)
////    }
//}
//
//extension PlayerViewController {
//    
//    @objc func timerCount() {
//        if timeElapsed != totalTime && timeElapsed < totalTime {
//            timeElapsed += 1
//            progressView.progress = Float(timeElapsed/totalTime)
//            
//            if timeElapsed < 10 {
//                timeCount.text = "0:0\(timeFormatter(interval: timeElapsed))"
//            } else if timeElapsed <= 59 {
//                timeCount.text = "0:\(timeFormatter(interval: timeElapsed))"
//            } else {
//                timeCount.text = timeFormatter(interval: timeElapsed)
//            }
//            
//            if totalTime - timeElapsed < 10 {
//                timeLeft.text = "-0:0\(timeFormatter(interval: totalTime - timeElapsed))"
//            } else if totalTime - timeElapsed < 60 {
//                timeLeft.text = "-0:\(timeFormatter(interval: totalTime - timeElapsed))"
//            } else {
//                timeLeft.text = "-\(timeFormatter(interval: totalTime - timeElapsed))"
//            }
//        } else {
//            resetPlayer()
//        }
//    }
//    
//    @objc func didTapSpeaker() {
//        speakerButton.setBackgroundImage(UIImage(systemName: "speaker.wave.1.fill"), for: .normal)
//        volumeView.isHidden = false
//    }
//    
//
//    @objc func didTapNext() {
//        if position < (songs.count - 1) {
//            timeElapsed = 0.0
//            position = position + 1
//            player?.stop()
//            for subview in holder.subviews {
//                subview.removeFromSuperview()
//            }
//            configure()
//        }
//    }
//
//    
//    @objc func didSlideSlider(_ slider: UISlider) {
//        volume = slider.value
//        player?.volume = volume
//    }
