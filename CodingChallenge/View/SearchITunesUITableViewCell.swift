//
//  SearchITunesUITableViewCell.swift
//  CodingChallenge
//
//  Created by Michelle M on 22/11/2019.
//  Copyright © 2019 iOSPractices. All rights reserved.
//

import UIKit

class SearchITunesUITableViewCell: UITableViewCell {
    var searchFormatted: SearchITunesFormatted!
    
    var trackName: String = ""
    var artworkUrl60: String = ""
    var trackPrice: String = ""
    var primaryGenreName: String = ""
    var longDescription: String = ""
    
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artworkUrl60ImageView: UIImageView!
    @IBOutlet weak var trackPriceLabel: UILabel!
    @IBOutlet weak var primaryGenreNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(searchFormatted: SearchITunesFormatted) {
        self.searchFormatted = searchFormatted
        self.trackNameLabel.text = self.searchFormatted.trackName
        self.trackPriceLabel.text = self.searchFormatted.trackPrice
        self.primaryGenreNameLabel.text = self.searchFormatted.primaryGenreName
        self.longDescription = self.searchFormatted.longDescription
        
        let url = URL(string: self.searchFormatted.artworkUrl60)
        let data = try? Data(contentsOf: url!)
        let img = UIImage(data: data!)
        
        self.artworkUrl60ImageView.image = img
    }
    
}
