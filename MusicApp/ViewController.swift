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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        configureSongs()
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

