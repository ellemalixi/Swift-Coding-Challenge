//
//  MasterViewController.swift
//  CodingChallenge
//
//  Created by Michelle M on 20/11/2019.
//  Copyright © 2019 iOSPractices. All rights reserved.

import UIKit

class MasterViewController: UITableViewController {

    @IBOutlet weak var dataTable: UITableView!
    var objects = Storage.shared.obj

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "iTunes Search Results"
        
        self.dataTable!.register(UINib(nibName: "SearchITunesUITableViewCell", bundle: nil), forCellReuseIdentifier: "ITunesCell")
        self.dataTable.rowHeight = 180
        // hide last few lines of tableView
        let footer: UIView = UIView.init(frame: CGRect.zero)
        self.dataTable.tableFooterView = footer;
        
        self.getData()
        
        // To save last screen user was on.
        self.restorationIdentifier = "SavedMasterVC"
    }
    
    func getData() {
        let requestString = "https://itunes.apple.com/search?term=star&country=au&media=movie&all"
        var statusCode = ""
        
        let url = URL(string: requestString)
        var request = URLRequest(url: url!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                statusCode = "\(httpResponse.statusCode)"
                print("statusCode: \(statusCode)")
            }
            
            if error != nil {
                DispatchQueue.main.async {
                    let msg = "Error retrieving information. Try again."
                    print("debug \(msg)")
                }
            } else {
                if let notNildata = data {
                    let tempData = try! JSONDecoder().decode(ITunesSearch.self, from: notNildata)
                    
                    print("debug \(tempData)")
                    
                    let resultCount = tempData.resultCount ?? 0
                    if resultCount > 0 {
                        if let resultsTemp = tempData.results {
                            for resultsActual in resultsTemp {
                                self.objects.append(resultsActual!)
                            }
                            DispatchQueue.main.async {
                                self.dataTable.reloadData()
                            }
                        }
                    }
                }
            }
        }
        dataTask.resume()
    }
    
    // MARK: - Table View Data Source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let searchResult: ITunesSearchResult = self.objects[indexPath.row]
        
        // reuses cells
        let cell = tableView.dequeueReusableCell(withIdentifier: "ITunesCell", for: indexPath) as! SearchITunesUITableViewCell
        
        // getting position or row
        
        cell.artworkUrlImageView.image = UIImage(named: "placeholder")
        
        cell.configureCell(aTrackName: searchResult.trackName ?? "Untitled", aPrice: "\(searchResult.currency!) \(searchResult.trackPrice ?? 0.00)", aGenre: searchResult.primaryGenreName ?? "No Genre", aArtworkUrl: searchResult.artworkUrl100!)
        
        return cell
    }
    
    // MARK: - UITableViewDelegate

    override func tableView(_ didSelectRowAttableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchResults: ITunesSearchResult = self.objects[indexPath.row]

        let detailViewController: DetailViewController = DetailViewController(nibName:"DetailViewController", bundle: nil, aChosenSearchResult: searchResults)
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
