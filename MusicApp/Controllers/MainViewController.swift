//
//  ViewController.swift
//  MusicApp
//
//  Created by Akbarshah Jumanazarov on 3/22/23.
//

//import UIKit
//import AVFoundation
//import Hero
//
//class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
//    
//    var player: AVAudioPlayer?
//    var songs = [SongModel]()
//    var timer = Timer()
//    
//    var timeElapsed: Double = 0
//    var position: Int = 0
//    var totalTime: Double = 0
//    var volume: Float = 0
//    var isPlaying: Bool = false
//    
//    private let playerView: UIView = {
//        let view = UIView()
//        view.isHidden = true
//        view.backgroundColor = .clear
//        view.layer.masksToBounds = true
//        view.layer.cornerRadius = 10
//        view.layer.borderColor = UIColor.label.cgColor
//        view.layer.borderWidth = 1
//        return view
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .mainBgColor
//        tableView.backgroundColor = .mainBgColor
//        tableView.layer.cornerRadius = 10
//        configureSongs()
//        addSubviews()
//        
//        tableView.delegate = self
//        tableView.dataSource = self
//        
//        //Blur effect
//        blur(playerView, style: .prominent)
//        
//        playPauseButton.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
//        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
//        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
//        
//        let gesRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
//        playerView.addGestureRecognizer(gesRecognizer)
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        view?.hero.isEnabled = true
//    }
//    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        view?.hero.isEnabled = false
//    }
//
//    @objc func timerCount() {
//        timeElapsed += 1
//    }
//    
//    @objc func didTapView() {
//        guard let vc = storyboard?.instantiateViewController(withIdentifier: "player") as? PlayerViewController else {
//            return
//        }
//        vc.songs = songs
//        vc.position = position
//        vc.timeElapsed = timeElapsed
//        vc.isPlaying = true
//        player?.pause()
//        timer.invalidate()
//        
//        playerView.heroID = "view"
//        vc.view.heroID = "view"
//        playerImage.heroID = "image"
//        vc.albumImage.heroID = "image"
//        playerName.heroID = "songName"
//        vc.songLabel.heroID = "songName"
//        playerArtist.heroID = "Artist"
//        vc.artistLabel.heroID = "Artist"
//        playPauseButton.heroID = "PlayPause"
//        vc.playPauseBtn.heroID = "PlayPause"
//        nextButton.heroID = "Next"
//        vc.nextBtn.heroID = "Next"
//        backButton.heroID = "Back"
//        vc.backBtn.heroID = "Back"
//        
//        vc.hero.isEnabled = true
//        showHero(vc)
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        guard let vc = storyboard?.instantiateViewController(withIdentifier: "player") as? PlayerViewController else {
//            return
//        }
//        player?.stop()
//        timer.invalidate()
//        
//        vc.songs = songs
//        vc.position = indexPath.row
//        vc.completion = { position, timeElapsed, volume, isPlaying in
//            self.position = position
//            self.timeElapsed = timeElapsed
//            self.volume = volume
//            self.isPlaying = isPlaying
//            self.tableView.reloadData()
//            self.configure()
//            if isPlaying {self.startTimer()}
//        }
//        tableView.heroID = "table"
//        vc.view.heroID = "table"
//        vc.isHeroEnabled = true
//        showHero(vc)
//        
//        playerView.isHidden = false
//    }
//    
//    func startTimer() {
//        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerCount), userInfo: nil, repeats: true)
//    }
//}
//
//extension MainViewController {
//    
//    @objc func didTapPlayPause() {
//        if player?.isPlaying == true {
//            playPauseButton.setBackgroundImage(UIImage(systemName: "play.circle.fill"), for: .normal)
//            player?.pause()
//            timer.invalidate()
//        } else {
//            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
//            player?.play()
//            startTimer()
//        }
//    }
//    
//    @objc func didTapNext() {
//        if position < (songs.count - 1) {
//            timeElapsed = 0.0
//            position = position + 1
//            player?.stop()
//            configure()
//        }
//    }
//    
//    @objc func didTapBack() {
//        if position > 0 {
//            timeElapsed = 0.0
//            position = position - 1
//            player?.stop()
//            configure()
//        }
//    }
//}
