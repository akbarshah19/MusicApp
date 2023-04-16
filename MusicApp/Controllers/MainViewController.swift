//
//  ViewController.swift
//  MusicApp
//
//  Created by Akbarshah Jumanazarov on 3/22/23.
//

import UIKit
import AVFoundation
import Hero

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var player: AVAudioPlayer?
    var songs = [Song]()
    var timer = Timer()
    
    var timeElapsed: Double = 0
    var position: Int = 0
    var totalTime: Double = 0
    var volume: Float = 0
    var isPlaying: Bool = false

    @IBOutlet weak var tableView: UITableView!
    
    private let playerView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.backgroundColor = .clear
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.label.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let playerImage: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    
    private let playerName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let playerArtist: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        button.tintColor = UIColor(named: "greenTint")
        return button
    }()
    
    private let playPauseButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
        button.tintColor = UIColor(named: "greenTint")
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "backward.end.fill"), for: .normal)
        button.tintColor = UIColor(named: "greenTint")
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .mainBgColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .mainBgColor
        tableView.layer.cornerRadius = 10
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        configureSongs()
        addSubviews()
        
        //Blur effect
        blur(playerView, style: .prominent)
        
        playPauseButton.addTarget(self, action: #selector(didTapPlayPause), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        
        let gesRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        playerView.addGestureRecognizer(gesRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view?.hero.isEnabled = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        view?.hero.isEnabled = false
    }
    
    func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(playerView)
        playerView.addSubview(playerImage)
        playerView.addSubview(playerName)
        playerView.addSubview(playerArtist)
        playerView.addSubview(nextButton)
        playerView.addSubview(playPauseButton)
        playerView.addSubview(backButton)
    }
    
    override func viewDidLayoutSubviews() {
        playerView.frame = CGRect(x: 5, y: view.height - 140, width: view.width - 10, height: 80)
        playerImage.frame = CGRect(x: playerView.left + 5, y: playerView.height/2 - 30, width: 60, height: 60)
        playerName.frame = CGRect(x: playerImage.right + 10, y: playerImage.top + 20, width: 180, height: 20)
        playerArtist.frame = CGRect(x: playerImage.right + 10, y: playerName.bottom, width: 180, height: 20)
        nextButton.frame = CGRect(x: playerView.width - 25, y: playerView.height/2 - 10, width: 20, height: 20)
        playPauseButton.frame = CGRect(x: nextButton.left - 45, y: playerView.height/2 - 20, width: 40, height: 40)
        backButton.frame = CGRect(x: playPauseButton.left - 25, y: playerView.height/2 - 10, width: 20, height: 20)
    }
    
    func configureSongs() {
        songs.append(Song(name: "Call out my name",
                          albumName: "My Dear Melancholy",
                          artistName: "The Weeknd",
                          imageName: "cover1",
                          trackName: "music1"))
        songs.append(Song(name: "The Hills",
                          albumName: "Madness",
                          artistName: "The Weeknd",
                          imageName: "cover2",
                          trackName: "music2"))
        songs.append(Song(name: "Creepin",
                          albumName: "Featured Song",
                          artistName: "The Weeknd",
                          imageName: "cover3",
                          trackName: "music3"))
    }
    
    func configure() {
        let song = songs[position]
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else {
                return print("URL error")
            }
            
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            guard let player = player else {
                return print("Player error")
            }
            
            totalTime = Double(round(player.duration))
            player.volume = volume
            playerName.text = song.name
            playerArtist.text = song.artistName
            playerImage.image = UIImage(named: song.imageName)
            
            let shortStartDelay: TimeInterval = 0.05 // seconds
            let now: TimeInterval = player.deviceCurrentTime
            let timeDelayPlay: TimeInterval = now + shortStartDelay
                        
            if isPlaying {
                player.currentTime = timeElapsed // Specific time to start play
                player.play(atTime: timeDelayPlay)
            } else {
                player.pause()
                playPauseButton.setBackgroundImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            }
        } catch {
            print("Error occured!")
        }
    }
    
    @objc func timerCount() {
        timeElapsed += 1
    }
    
    @objc func didTapView() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "player") as? PlayerViewController else {
            return
        }
        vc.songs = songs
        vc.position = position
        vc.timeElapsed = timeElapsed
        vc.isPlaying = true
        player?.pause()
        timer.invalidate()
        
        playerView.heroID = "view"
        vc.view.heroID = "view"
        playerImage.heroID = "image"
        vc.albumImage.heroID = "image"
        playerName.heroID = "songName"
        vc.songLabel.heroID = "songName"
        playerArtist.heroID = "Artist"
        vc.artistLabel.heroID = "Artist"
        playPauseButton.heroID = "PlayPause"
        vc.playPauseBtn.heroID = "PlayPause"
        nextButton.heroID = "Next"
        vc.nextBtn.heroID = "Next"
        backButton.heroID = "Back"
        vc.backBtn.heroID = "Back"
        
        vc.hero.isEnabled = true
        showHero(vc)
    }
    
    @objc func didTapPlayPause() {
        if player?.isPlaying == true {
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.circle.fill"), for: .normal)
            player?.pause()
            timer.invalidate()
        } else {
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
            player?.play()
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerCount), userInfo: nil, repeats: true)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let song = songs[indexPath.row]
        cell.myImage.image = UIImage(named: song.imageName)
        cell.myLabel.text = song.name
        cell.myAlbum.text = song.artistName
        cell.playbackTIme.text = timeFormatter(interval: totalTime)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "player") as? PlayerViewController else {
            return
        }
        player?.stop()
        timer.invalidate()
        
        vc.songs = songs
        vc.position = indexPath.row
        vc.completion = { position, timeElapsed, volume, isPlaying in
            self.position = position
            self.timeElapsed = timeElapsed
            self.volume = volume
            self.isPlaying = isPlaying
            self.tableView.reloadData()
            self.configure()
            
            if isPlaying {
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerCount), userInfo: nil, repeats: true)
            }
        }
        tableView.heroID = "table"
        vc.view.heroID = "table"
        vc.isHeroEnabled = true
        showHero(vc)
        
        playerView.isHidden = false
    }
}
