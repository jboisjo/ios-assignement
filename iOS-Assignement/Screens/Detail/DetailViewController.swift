//
//  DetailViewController.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-24.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: BaseViewController<DetailView>, UITableViewDelegate {
    
    //MARK: Variables
    var viewModel: DetailViewModel!
    var items: [Items]?
    var videoItem: [String: ObjectPlaylist?]? = [:]
    
    var fetchMore = false
    var nextPageToken: String!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = DetailViewModel(repositoryManagerDelegate: RepositoryManager(networkManagerDelegate: NetworkManager()))
        
        getTracksFromRepository()
        setSelectedPlaylistData()
        setNavigationProperties()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false  //Hide
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true  //Show
    }
    
    //MARK: - Binding
    func setSelectedPlaylistData() {
        if let title = UserDefaults.standard.string(forKey: "selectedPlaylistTitle"),
            let tracks = UserDefaults.standard.string(forKey: "selectedPlaylistTracks")  {
            viewLayout.lblTitlePlaylistSelected.text = title
            viewLayout.lblTitleCount.text = "Number of tracks : \(tracks)" //this should come from localDB
            
            if let img = UserDefaults.standard.string(forKey: "selectedPlaylistImageUrl"), let imgURL = URL(string: img) {
                DispatchQueue.global().async {
                    let data = try? Data(contentsOf: imgURL)
                    if let data = data {
                        let image = UIImage(data: data)
                        DispatchQueue.main.async {
                            self.viewLayout.imgPlaylistSelected.image = image
                        }
                    }
                }
            }
        }
    }
    
    func setNavigationProperties() {
         self.navigationController?.navigationBar.barTintColor = UIColor.hexStringToUIColor(hex: "0a0a0a")
    }
    
    func setupTableView() {
        viewLayout.tracksTableView.delegate = self
        viewLayout.tracksTableView.dataSource = self
        
        let nib = UINib(nibName: "DetailViewTableViewCell", bundle: nil)
        viewLayout.tracksTableView.register(nib, forCellReuseIdentifier: "detailCellIdentifier")
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height {
            if !fetchMore {
                beganBatchFetch()
            }
            
        }
    }
    
    func beganBatchFetch() {
        fetchMore = true
        getListOfVideosFromRepository()
    }
    
    func getTracksFromRepository() {
        viewModel.getTracksFromPlaylist(success: { [weak self] (item) in
            self?.nextPageToken = item?.nextPageToken
            self?.items = item?.items
            item?.items?.forEach({ [weak self] (items) in
                if let videoId = items.contentDetails?.videoId {
                    self?.viewModel.getVideoDetailFromRepository(videoId: videoId, success: { [weak self] (result) in
                        self?.videoItem?[videoId] = result
                        
                        if self?.items?.count == self?.videoItem?.count {
                            DispatchQueue.main.async {
                                self?.viewLayout.tracksTableView.reloadData()
                            }
                        }
                    }) { (error) in
    
                    }
                }
            })
  
        }) { (error) in
            print(error as Any)
        }
    }
    
    func getListOfVideosFromRepository() {
        viewModel.getTracksFromPlaylist(nextPageToken: self.nextPageToken, success: { [weak self] (response) in
            self?.nextPageToken = response?.nextPageToken
            
            if let item = response?.items {
                self?.items?.append(contentsOf: item)
                
                item.forEach({ [weak self] (items) in
                    if let videoId = items.contentDetails?.videoId {
                        self?.viewModel.getVideoDetailFromRepository(videoId: videoId, success: { [weak self] (result) in
                            self?.videoItem?[videoId] = result
                            
                            if self?.items?.count == self?.videoItem?.count {
                                DispatchQueue.main.async {
                                    self?.viewLayout.tracksTableView.reloadData()
                                    self?.fetchMore = false
                                }
                            }
                        }) { (error) in
                        }
                    }
                })
            }
            
        }) { (error) in
            print(error as Any)
        }
    }
}

//MARK: - Delegate
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewLayout.tracksTableView.dequeueReusableCell(withIdentifier: "detailCellIdentifier", for: indexPath) as! DetailViewTableViewCell
        
        let selectedItem = self.items?[indexPath.row]
        
        if let videoItems = self.videoItem,
            let selectedVideoId = selectedItem?.contentDetails?.videoId,
            let valueFromDictionnary = videoItems[selectedVideoId],
            let value = valueFromDictionnary,
            let item = value.items {
            
            if item.count > 0 {
                if let title = item[0].snippet?.channelTitle, let duration = item[0].contentDetails?.duration {
                        cell.lblTrackNb.text = "\(title) • \(duration.formatISO8601())"
                }
                
            } else {
                cell.lblTrackNb.text = "Unknown"
            }
            
        } else {
            cell.lblTrackNb.text = "Unknown"
        }
        
        let image = self.items?[indexPath.row].snippet?.thumbnails?.standard?.url //to move in extension or function to clean.
        if let img = image, let imgURL = URL(string: img) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imgURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.imgTrack.image = image
                    }
                }
            }
        }
        
        cell.lblTitle.text = selectedItem?.snippet?.title
        
        return cell
    }
}
