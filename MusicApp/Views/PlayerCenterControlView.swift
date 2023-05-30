//
//  PlayerCenterControlView.swift
//  MusicApp
//
//  Created by Akbarshah Jumanazarov on 5/22/23.
//

import UIKit

class PlayerCenterControlView: UIView {
    private let playPauseBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let nextBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "forward.end.alt.fill"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private let backBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "backward.end.alt.fill"), for: .normal)
        button.tintColor = .label
        return button
    }()
    
    private var volumeView: UIButton = {
        let button = UIButton()
        button.isHidden = true
        button.backgroundColor = .secondarySystemBackground
        button.layer.masksToBounds = true
        
        button.layer.borderColor = UIColor(named: "greenTint")?.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    private let speakerButton: UIButton = {
        let button = UIButton()
        return button
    }()

    private let dismissBtn: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "chevron.compact.down"), for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 8
        button.tintColor = .lightGray
        return button
    }()
}
