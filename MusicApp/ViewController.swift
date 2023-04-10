//
//  ViewController.swift
//  MusicApp
//
//  Created by Akbarshah Jumanazarov on 3/22/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var songs = [Song]()

    @IBOutlet weak var tableView: UITableView!
    
    private let playerView: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    
    private let playerImage: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 8
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.darkGray.cgColor
        return image
    }()
    
    private let playerLabel: UILabel = {
        let label = UILabel()
        label.text = "Hello"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private let artistLabel: UILabel = {
        let label = UILabel()
        label.text = "Drake"
        label.font = .systemFont(ofSize: 18, weight: .thin)
        return label
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "forward.end.fill"), for: .normal)
        return button
    }()
    
    private let playPauseButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "play.circle.fill"), for: .normal)
        return button
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "backward.end.fill"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        configureSongs()
        
        view.addSubview(playerView)
        playerView.addSubview(playerImage)
        playerView.addSubview(playerLabel)
        playerView.addSubview(artistLabel)
        playerView.addSubview(nextButton)
        playerView.addSubview(playPauseButton)
        playerView.addSubview(backButton)
    }
    
    override func viewDidLayoutSubviews() {
        playerView.frame = CGRect(x: 10, y: view.height - 110, width: view.width - 20, height: 80)
        playerImage.frame = CGRect(x: playerView.left + 0, y: playerView.height/2 - 30, width: 60, height: 60)
        playerLabel.frame = CGRect(x: playerImage.right + 10, y: playerImage.top + 20, width: 180, height: 20)
        artistLabel.frame = CGRect(x: playerImage.right + 10, y: playerLabel.bottom, width: 180, height: 20)
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let song = songs[indexPath.row]
        cell.myImage.image = UIImage(named: song.imageName)
        cell.myLabel.text = song.name
        cell.myAlbum.text = song.artistName
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let position = indexPath.row
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "player") as? PlayerViewController else {
            return
        }
        
        vc.songs = songs
        vc.position = position
        
        present(vc, animated: true)
    }
}

struct Song {
    let name: String
    let albumName: String
    let artistName: String
    let imageName: String
    let trackName: String
}

