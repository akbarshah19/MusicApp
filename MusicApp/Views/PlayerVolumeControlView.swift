//
//  PlayerVolumeControlView.swift
//  MusicApp
//
//  Created by Akbarshah Jumanazarov on 5/22/23.
//

import UIKit

class PlayerVolumeControlView: UIView {
    private let muteButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "speaker.slash"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let volumeDownImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "minus")
        image.tintColor = .label
        return image
    }()
    
    private let volumeUpImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(systemName: "plus")
        image.tintColor = .label
        return image
    }()
    
    private let volumeSlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = UIColor(named: "greenTint")
        slider.setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
        slider.value = 0.5
        return slider
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        backgroundColor = .secondarySystemBackground
        addSubviews()
        
        volumeSlider.addTarget(self, action: #selector(didSlideSlider(_ :)), for: .valueChanged)
        muteButton.addTarget(self, action: #selector(didTapMuteButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubviews() {
        addSubview(muteButton)
        addSubview(volumeDownImage)
        addSubview(volumeUpImage)
        addSubview(volumeSlider)
    }
    
    @objc func didSlideSlider(_ sender: UISlider) {
        
    }
    
    @objc func didTapMuteButton() {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        muteButton.frame = CGRect(x: right - 20 - 20 - 30, y: height/2 - 10, width: 20, height: 20)
        volumeDownImage.frame = CGRect(x: left - 30 + 10, y: height/2 - 2, width: 20, height: 4)
        volumeUpImage.frame = CGRect(x: muteButton.left - 10 - 30, y: height/2 - 8, width: 20, height: 16)
        volumeSlider.frame = CGRect(x: volumeDownImage.right + 5,
                                    y: height/2 - 10,
                                    width: (width - 60) - volumeDownImage.left - 40 - 10,
                                    height: 20)
    }
}
