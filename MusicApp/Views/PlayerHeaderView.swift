//
//  PlayerHeaderView.swift
//  MusicApp
//
//  Created by Akbarshah Jumanazarov on 5/26/23.
//

import UIKit

class PlayerHeaderView: UIView {

    let slider: UISlider = {
        let slider = UISlider()
        slider.setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
        return slider
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: String) {
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
