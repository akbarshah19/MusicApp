//
//  TableViewCell.swift
//  MusicApp
//
//  Created by Akbarshah Jumanazarov on 3/22/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var myImage: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myAlbum: UILabel!
    @IBOutlet weak var playbackTIme: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .secondarySystemBackground
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
