//
//  PlayerViewController.swift
//  MusicApp
//
//  Created by Akbarshah Jumanazarov on 3/23/23.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    public var position: Int = 0
    public var songs: [Song] = []
    
    @IBOutlet weak var holder: UIView!
    
    private let dismissBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.tintColor = .lightGray
        return button
    }()
    
    private let albumImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 15
        return image
    }()
    
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var player: AVAudioPlayer?
    let playPauseBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        if holder.subviews.count == 0 {
            configure()
        }
    }
    
    func configure() {
        let song = songs[position]
        
        let urlString = Bundle.main.path(forResource: song.trackName, ofType: "mp3")
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else {
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            
            guard let player = player else {
                return
            }
            player.volume = 0.5
            player.play()
            
        } catch {
            print("Error occured!")
        }
        
        dismissBtn.frame = CGRect(x: holder.width/2 - 25, y: 10, width: 50, height: 20)
        dismissBtn.addTarget(self, action: #selector(didTapDismiss), for: .touchUpInside)
        holder.addSubview(dismissBtn)
        
        albumImageView.frame = CGRect(x: 30, y: dismissBtn.bottom + 20, width: holder.width - 60, height: holder.width - 60)
        albumImageView.image = UIImage(named: song.imageName)
        holder.addSubview(albumImageView)
        
        //Labels
        
        artistNameLabel.frame = CGRect(x: 10, y: albumImageView.bottom + 5, width: holder.width - 20, height: 17)
        songNameLabel.frame = CGRect(x: 10, y: artistNameLabel.bottom + 10, width: holder.width - 20, height: 26)
        albumNameLabel.frame = CGRect(x: 10, y: songNameLabel.bottom + 10, width: holder.width - 20, height: 17)
        
        artistNameLabel.text = song.artistName
        songNameLabel.text = song.name
        albumNameLabel.text = song.albumName
        
        artistNameLabel.font = .systemFont(ofSize: 15, weight: .regular)
        songNameLabel.font = .systemFont(ofSize: 24, weight: .heavy)
        albumNameLabel.font = .systemFont(ofSize: 15, weight: .regular)
        
        
        holder.addSubview(songNameLabel)
        holder.addSubview(albumNameLabel)
        holder.addSubview(artistNameLabel)
        
        //Buttons
        
        let nextBtn = UIButton()
        let backBtn = UIButton()
        
        playPauseBtn.addTarget(self, action: #selector(didTapPause), for: .touchUpInside)
        nextBtn.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        backBtn.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        
        playPauseBtn.tintColor = .black
        nextBtn.tintColor = .black
        backBtn.tintColor = .black
        
        playPauseBtn.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        nextBtn.setBackgroundImage(UIImage(systemName: "forward.end.alt.fill"), for: .normal)
        backBtn.setBackgroundImage(UIImage(systemName: "backward.end.alt.fill"), for: .normal)
        
        playPauseBtn.frame = CGRect(x: holder.width/2 - 20, y: albumNameLabel.bottom + 15, width: 40, height: 40)
        nextBtn.frame = CGRect(x: playPauseBtn.right + 20, y: albumNameLabel.bottom + 15 + 10, width: 40, height: 20)
        backBtn.frame = CGRect(x: playPauseBtn.left - 20 - 40, y: albumNameLabel.bottom + 15 + 10, width: 40, height: 20)
        
        holder.addSubview(playPauseBtn)
        holder.addSubview(nextBtn)
        holder.addSubview(backBtn)
        
        //Slider
        
        let slider = UISlider(frame: CGRect(x: 20, y: playPauseBtn.bottom + 20, width: holder.width - 40, height: 30))
        slider.value = 0.5
        slider.addTarget(self, action: #selector(didSlideSlider(_ :)), for: .valueChanged)
        holder.addSubview(slider)
        
        let volumeUpImage = UIImageView(frame: CGRect(x: slider.left, y: playPauseBtn.bottom, width: 30, height: 20))
        volumeUpImage.image = UIImage(systemName: "speaker.minus.fill")
        let volumeDownImage = UIImageView(frame: CGRect(x: slider.right - 30, y: playPauseBtn.bottom, width: 30, height: 20))
        volumeDownImage.image = UIImage(systemName: "speaker.plus.fill")
        
        holder.addSubview(volumeUpImage)
        holder.addSubview(volumeDownImage)
    }
    
    @objc func didTapDismiss() {
        self.dismiss(animated: true)
    }
    
    @objc func didTapBack() {
        if position > 0 {
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
            position = position + 1
            player?.stop()
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    @objc func didTapPause() {
        if player?.isPlaying == true {
            player?.pause()
            playPauseBtn.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            
            //shrink image
            
            UIView.animate(withDuration: 0.2) {
                self.albumImageView.frame = CGRect(x: 50, y: self.dismissBtn.bottom + 40, width: self.holder.width - 100, height: self.holder.width - 100)
            }
            
        } else {
            player?.play()
            playPauseBtn.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            
            //increase image size
            
            UIView.animate(withDuration: 0.2) {
                self.albumImageView.frame = CGRect(x: 30, y: self.dismissBtn.bottom + 20, width: self.holder.width - 60, height: self.holder.width - 60)
            }
            
        }
    }
    
    @objc func didSlideSlider(_ slider: UISlider) {
        let value = slider.value
        
        player?.volume = value
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if let player = player {
            player.stop()
        }
    }
}
