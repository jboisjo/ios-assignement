//
//  ListViewController.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-24.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import Foundation
import UIKit

class ListViewController: BaseViewController<ListView>, UITableViewDelegate {

    var viewModel: ListViewModel!
    var items: [Items]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ListViewModel(repositoryManagerDelegate: RepositoryManager(networkManagerDelegate: NetworkManager()))
  
        viewLayout.navigationBar.topItem?.title = "iOS-Assignement"
        setupTableView()
        getRepositoryFromVM()
    }
    
    func getRepositoryFromVM() {
        viewModel.getUserFromRepository(success: { (response) in
                   self.items = response?.items
                   
                   DispatchQueue.main.async {
                       self.viewLayout.listTableView.reloadData()
                   }
                   
               }) { (error) in
                   print(error ?? "")
               }
    }
    
    func setupTableView() {
        viewLayout.listTableView.delegate = self
        viewLayout.listTableView.dataSource = self
        
        let nib = UINib(nibName: "ListViewCell", bundle: nil)
        viewLayout.listTableView.register(nib, forCellReuseIdentifier: "cellIdentifier")
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewLayout.listTableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as! ListViewCell
        
        cell.titleLbl.text = self.items?[indexPath.row].snippet?.title
        
        if let count = self.items?[indexPath.row].contentDetails?.itemCount {
            cell.descriptionLbl.text = String(describing: "\(count) songs")
        }
        
        let image = self.items?[indexPath.row].snippet?.thumbnails?.standard?.url //to move in extension or function to clean.
        if let img = image, let imgURL = URL(string: img) {
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: imgURL)
                if let data = data {
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.imgThumbnail.image = image
                    }
                }
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPlaylistId = self.items?[indexPath.row].id
        let selectedPlaylistTitle = self.items?[indexPath.row].snippet?.title
        let selectedPlaylistTracks = self.items?[indexPath.row].contentDetails?.itemCount
        let selectedPlaylistImageUrl = self.items?[indexPath.row].snippet?.thumbnails?.standard?.url
        
        UserDefaults.standard.set(selectedPlaylistId, forKey: "selectedPlaylistId") //cache for local
        UserDefaults.standard.set(selectedPlaylistTitle, forKey: "selectedPlaylistTitle") //cache for local
        UserDefaults.standard.set(selectedPlaylistTracks, forKey: "selectedPlaylistTracks") //cache for local
        UserDefaults.standard.set(selectedPlaylistImageUrl, forKey: "selectedPlaylistImageUrl") //cache for local
        
        navigationController?.pushViewController(DetailViewController(), animated: true)
    }
    
}
