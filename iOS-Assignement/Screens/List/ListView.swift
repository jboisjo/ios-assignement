//
//  ListView.swift
//  iOS-Assignement
//
//  Created by Jérémie Boisjoli on 2020-01-24.
//  Copyright © 2020 Jérémie Boisjoli. All rights reserved.
//

import UIKit

class ListView: NibView {
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        listTableView.rowHeight = 100
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
