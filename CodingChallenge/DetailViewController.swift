//
//  DetailViewController.swift
//  CodingChallenge
//
//  Created by Michelle M on 20/11/2019.
//  Copyright © 2019 iOSPractices. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var chosenSearchResult: ITunesSearchResult?
    
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var trackPriceLabel: UILabel!
    @IBOutlet weak var primaryGenreLabel: UILabel!
    @IBOutlet weak var longDescTextView: UITextView!
    @IBOutlet weak var artworkImageView: UIImageView!
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?, aChosenSearchResult:ITunesSearchResult) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
        self.chosenSearchResult = aChosenSearchResult
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Details"
        self.initUI()
        
        // To save last screen user was on.
        self.restorationIdentifier = "SavedDetailVC"
    }
    
    // MARK: - Image Utility
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    // MARK: - Customization
    
    var detailItem: ITunesSearchResult? {
        didSet {
            // Update the view.
            self.initUI()
        }
    }
    
    func initUI() {
            let trackName = self.chosenSearchResult?.trackName ?? ""
            _ = self.chosenSearchResult?.artworkUrl100 ?? ""
            let trackPrice = self.chosenSearchResult?.trackPrice ?? 0.0
            let country = self.chosenSearchResult?.country ?? ""
            let currency = self.chosenSearchResult?.currency ?? ""
            let primaryGenreName = self.chosenSearchResult?.primaryGenreName ?? ""
            let longDescription = self.chosenSearchResult?.longDescription ?? ""
            
            let detail = """
            Track Name:  \(trackName)
            Genre:  \(primaryGenreName)
            Country:  \(country)
            Long Description:  \(longDescription)
            """
            self.trackNameLabel.text = self.chosenSearchResult?.trackName
            self.trackPriceLabel.text = "\(currency) \(trackPrice)"
            self.primaryGenreLabel.text = primaryGenreName
            
            self.longDescTextView.text = detail
            
        if let artworkUrl = self.chosenSearchResult?.artworkUrl100 {
                let url = URL(string: artworkUrl)
                
                var artworkImage: UIImage?
                
                getData(from: url!) { data, response, error in
                    guard let data = data, error == nil else { return }
                    print(response?.suggestedFilename ?? url!.lastPathComponent)
                    print("Download Finished")
                    DispatchQueue.main.async() {
                        artworkImage = UIImage(data: data)
                        self.artworkImageView.image = artworkImage
                    }
                }
            }
        }
}
