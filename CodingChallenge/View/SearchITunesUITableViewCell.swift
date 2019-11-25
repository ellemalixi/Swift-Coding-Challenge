//
//  SearchITunesUITableViewCell.swift
//  CodingChallenge
//
//  Created by Michelle M on 22/11/2019.
//  Copyright © 2019 iOSPractices. All rights reserved.
//

import UIKit

class SearchITunesUITableViewCell: UITableViewCell {
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artworkUrlImageView: UIImageView!
    @IBOutlet weak var trackPriceLabel: UILabel!
    @IBOutlet weak var primaryGenreNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.restorationIdentifier = "SavedCell"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Image Utility
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    // MARK: - Customization
    
    func configureCell(aTrackName:String, aPrice:String, aGenre:String, aArtworkUrl:String) {
        self.trackNameLabel.text = aTrackName
        self.trackNameLabel.adjustsFontSizeToFitWidth = true
        self.trackPriceLabel.text = aPrice
        self.primaryGenreNameLabel.text = aGenre
        
        let url = URL(string: aArtworkUrl)
        
        var artworkImage: UIImage?
        
        print("Download Started")
        getData(from: url!) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url!.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                artworkImage = UIImage(data: data)
                self.artworkUrlImageView.image = artworkImage
            }
        }
    }
}
