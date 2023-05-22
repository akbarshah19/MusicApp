//
//  SubPlayerView.swift
//  MusicApp
//
//  Created by Akbarshah Jumanazarov on 5/22/23.
//

import UIKit

class SubPlayerView: UIView {
    
    public let playerImage: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    
    public let playerName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    public let playerArtist: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .regular)
        return label
    }()
    
    public let nextButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "forward.end.fill"), for: .normal)
//        button.tintColor = UIColor(named: "greenTint")
        return button
    }()
    
    public let playPauseButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "pause.circle.fill"), for: .normal)
//        button.tintColor = UIColor(named: "greenTint")
        return button
    }()
    
    public let backButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "backward.end.fill"), for: .normal)
//        button.tintColor = UIColor(named: "greenTint")
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = .red
        
        addSubview(playerName)
        addSubview(playerName)
        addSubview(playerArtist)
        addSubview(nextButton)
        addSubview(playPauseButton)
        addSubview(backButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: SongModel) {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        playerImage.frame = CGRect(x: 0, y: height/2 - 30, width: 60, height: 60)
        playerName.frame = CGRect(x: playerImage.right + 10, y: playerImage.top + 20, width: 180, height: 20)
        playerArtist.frame = CGRect(x: playerImage.right + 10, y: playerName.bottom, width: 180, height: 20)
        nextButton.frame = CGRect(x: width - 25, y: height/2 - 10, width: 20, height: 20)
        playPauseButton.frame = CGRect(x: nextButton.left - 45, y: height/2 - 20, width: 40, height: 40)
        backButton.frame = CGRect(x: playPauseButton.left - 25, y: height/2 - 10, width: 20, height: 20)
    }
}
