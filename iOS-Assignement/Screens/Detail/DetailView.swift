//
//  DetailView.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-24.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import UIKit

class DetailView: NibView {

    @IBOutlet weak var imgPlaylistSelected: UIImageView!
    @IBOutlet weak var lblTitlePlaylistSelected: UILabel!
    @IBOutlet weak var lblTitleCount: UILabel!
    @IBOutlet weak var tracksTableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tracksTableView.rowHeight = 100
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
