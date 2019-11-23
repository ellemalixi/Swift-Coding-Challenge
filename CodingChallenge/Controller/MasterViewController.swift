//
//  MasterViewController.swift
//  CodingChallenge
//
//  Created by Michelle M on 20/11/2019.
//  Copyright © 2019 iOSPractices. All rights reserved.
//

import UIKit
import Alamofire

class MasterViewController: UITableViewController {

    @IBOutlet weak var dataTable: UITableView!
    var detailViewController: DetailViewController? = nil
    var objects = Storage.shared.obj
    var dataArray: [SearchITunesFormatted] = [SearchITunesFormatted]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        navigationItem.leftBarButtonItem = editButtonItem

//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
//        navigationItem.rightBarButtonItem = addButton
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        self.dataTable.register(UINib(nibName: "SearchITunesUITableViewCell", bundle: nil), forCellReuseIdentifier: "ITunesCell")
        
        makeAPICall()
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

//    @objc
//    func insertNewObject(_ sender: Any) {
//        performSegue(withIdentifier: "showList", sender: self)
//    }
    
    // MARK: - API Call
    func makeAPICall() {
        let url: String = "https://itunes.apple.com/search?term=star&amp;country=au&amp;media=movie&amp;all"
        Alamofire.request(url) .responseData { response in
            
            let jsonData = response.data
            if let notNildata = jsonData {
                // decodes JSON
                let tempData = try! JSONDecoder().decode(SearchITunesMain.self, from: notNildata)
                
                if let movieList = tempData.Search {
                    for movie in movieList {
                        // initialize searchITunesFormatted
                        var movieSearchFormatted: SearchITunesFormatted = SearchITunesFormatted(trackName: "", artworkUrl60: "", trackPrice: "", primaryGenreName: "", longDescription: "")
                        
                        movieSearchFormatted.trackName = movie?.trackName ?? ""
                        movieSearchFormatted.trackPrice = movie?.trackPrice ?? ""
                        movieSearchFormatted.artworkUrl60 = movie?.artworkUrl60 ?? ""
                        movieSearchFormatted.primaryGenreName = movie?.primaryGenreName ?? ""
                        movieSearchFormatted.longDescription = movie?.longDescription ?? ""
                        
                        self.dataArray.append(movieSearchFormatted)
                    }
                    
                    // reloads rows and sections in table view
//                    self.dataTable.reloadData()
                    
                }
            }
        }
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
                detailViewController = controller
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // reuses cells
        let cell = tableView.dequeueReusableCell(withIdentifier: "ITunesCell", for: indexPath) as! SearchITunesUITableViewCell
//        let object = objects[indexPath.row]
        
        // getting position or row
        
        let tempITunesFormatted: SearchITunesFormatted = self.dataArray[indexPath.row]
        
        cell.configure(searchFormatted: tempITunesFormatted)
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

