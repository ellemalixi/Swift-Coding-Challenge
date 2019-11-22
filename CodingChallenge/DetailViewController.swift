//
//  DetailViewController.swift
//  CodingChallenge
//
//  Created by Michelle M on 20/11/2019.
//  Copyright © 2019 iOSPractices. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var trackPriceLabel: UILabel!
    @IBOutlet weak var primaryGenreLabel: UILabel!
    @IBOutlet weak var longDescTextView: UITextView!
    @IBOutlet weak var artworkImageView: UIImageView!
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = trackNameLabel {
                label.text = detail.trackName!
            }
            
            if let label = trackPriceLabel {
                label.text = detail.trackPrice!
            }
            
            if let label = primaryGenreLabel {
                label.text = detail.primaryGenreName!
            }
            
            if let textView = longDescTextView {
                textView.text = detail.longDescription!
            }
            
            if let imageView = artworkImageView {
                imageView.image! = detail.artworkUrl60! as! UIImage
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }

    var detailItem: SearchITunes? {
        didSet {
            // Update the view.
            configureView()
        }
    }
}

