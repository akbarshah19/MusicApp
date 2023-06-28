//
//  HomeViewController.swift
//  MusicApp
//
//  Created by Akbarshah Jumanazarov on 5/21/23.
//

import UIKit
import AVFoundation
import Hero

class HomeViewController: UIViewController {
    var player: AVAudioPlayer?
    
    var songs: [SongModel] = [
        SongModel(name: "Call out my name",
                  albumName: "My Dear Melancholy",
                  artistName: "The Weeknd",
                  imageName: "cover1",
                  trackName: "music1"),
        SongModel(name: "The Hills",
                  albumName: "Madness",
                  artistName: "The Weeknd",
                  imageName: "cover2",
                  trackName: "music2"),
        SongModel(name: "Creepin",
                  albumName: "Featured Song",
                  artistName: "The Weeknd",
                  imageName: "cover3",
                  trackName: "music3")
    ]
    
    var position: Int = 0
    var timeElapsed: Double = 0
    var totalTime: Double = 0
    var volume: Float = 0
    var isPlaying: Bool = true
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(HomeTableViewCell.self, forCellReuseIdentifier: HomeTableViewCell.identifier)
        return table
    }()
    
    private let subPlayer: HomeSubPlayerView = {
        let view = HomeSubPlayerView()
        
        return view
    }()
    
    var timer = Timer()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        addSubviews()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configure(with position: Int) {
        let urlString = Bundle.main.path(forResource: songs[position].trackName, ofType: "mp3")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            guard let urlString = urlString else { return print("Audio URL error!") }
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            guard let player = player else { return print("Player error occured.") }
            player.play()
        } catch {
            print("Error occured!")
        }
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
        view.addSubview(subPlayer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        subPlayer.frame = CGRect(x: 0, y: view.bottom - 140, width: view.width, height: 80)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HomeTableViewCell.identifier, for: indexPath) as! HomeTableViewCell
        cell.configure(with: songs[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = PlayerViewController(position: indexPath.row, songs: songs)
        vc.modalPresentationStyle = .fullScreen
        configure(with: indexPath.row)
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

