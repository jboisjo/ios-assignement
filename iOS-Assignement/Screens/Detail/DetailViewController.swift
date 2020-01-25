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
    
    var viewModel: DetailViewModel!
    var items: [Items]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barTintColor = UIColor.darkGray
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        if let title = UserDefaults.standard.string(forKey: "selectedPlaylistTitle"),
            let tracks = UserDefaults.standard.string(forKey: "selectedPlaylistTracks")  {
            viewLayout.lblTitlePlaylistSelected.text = title
            viewLayout.lblTitleCount.text = "Number of tracks : \(tracks)"
            
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
        
        
        viewModel = DetailViewModel(repositoryManagerDelegate: RepositoryManager(networkManagerDelegate: NetworkManager()))
        viewModel.getUserFromRepository(success: { (item) in
            self.items = item?.items
            
            DispatchQueue.main.async {
                self.viewLayout.tracksTableView.reloadData()
            }
        }) { (error) in
            print(error as Any)
        }
        
        setupTableView()
    }
    
    func setupTableView() {
        viewLayout.tracksTableView.delegate = self
        viewLayout.tracksTableView.dataSource = self
        
        let nib = UINib(nibName: "DetailViewTableViewCell", bundle: nil)
        viewLayout.tracksTableView.register(nib, forCellReuseIdentifier: "detailCellIdentifier")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false  //Hide
    }

    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true  //Show
    }
}

extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewLayout.tracksTableView.dequeueReusableCell(withIdentifier: "detailCellIdentifier", for: indexPath) as! DetailViewTableViewCell
        
        cell.lblTitle.text = self.items?[indexPath.row].snippet?.title
        
        if let count = self.items?[indexPath.row].contentDetails?.itemCount {
            cell.lblTrackNb.text = String(describing: "\(count) songs")
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
        
        return cell
    }
    
    
}
