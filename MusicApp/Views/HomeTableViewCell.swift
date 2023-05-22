//
//  MainTableViewCell.swift
//  MusicApp
//
//  Created by Akbarshah Jumanazarov on 5/21/23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    static let identifier = "HomeTableViewCell"
    
    private let albumCover: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.layer.cornerRadius = 8
        return image
    }()
    
    private let albumLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private let songLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private let artistLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .secondarySystemBackground
        clipsToBounds = true
        
        contentView.addSubview(albumCover)
        contentView.addSubview(albumLabel)
        contentView.addSubview(songLabel)
        contentView.addSubview(artistLabel)
    }
    
    func configure(with model: SongModel) {
        albumCover.image = UIImage(named: model.imageName)
        songLabel.text = model.name
        artistLabel.text = model.artistName
        albumLabel.text = model.albumName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        albumCover.image = nil
        albumLabel.text = nil
        songLabel.text = nil
        artistLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        albumCover.frame = CGRect(x: 10, y: 5, width: contentView.height - 10, height: contentView.height - 10)
        songLabel.frame = CGRect(x: albumCover.right + 10, y: 0, width: contentView.width - albumCover.width - 30, height: 24)
        songLabel.center.y = contentView.center.y
        albumLabel.frame = CGRect(x: albumCover.right + 10, y: songLabel.top - 12, width: contentView.width - albumCover.width - 30, height: 12)
        artistLabel.frame = CGRect(x: albumCover.right + 10, y: songLabel.bottom, width: contentView.width - albumCover.width - 30, height: 12)
    }
}
