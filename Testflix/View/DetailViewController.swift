//
//  DetailViewController.swift
//  Testflix
//
//  Created by Victor Valfre on 23/04/19.
//  Copyright © 2019 Victor Valfre. All rights reserved.
//

import Foundation
import UIKit


class DetailViewController: UITableViewController {
    let movieId = "movieId"
    var filme: Filme?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderView()
    }
    
    func setupHeaderView(){
        let width = tableView.frame.width
        let header = UIView(frame: CGRect(x: 0, y: 0, width: width, height: (width * (9/16) + 32)))
        
        let imgView = UIImageView()
        imgView.backgroundColor = .red
        header.addSubview(imgView)
        
        let lbl = UILabel()
        lbl.text = filme?.title
        lbl.textColor = .white
        lbl.backgroundColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.textAlignment = .center
        header.addSubview(lbl)
        
        header.constraint(pattern: "H:|[v0]|", views: imgView, lbl)
        header.constraint(pattern: "V:|[v0][v1(32)]-10-|", views: imgView, lbl)
        
        tableView.tableHeaderView = header
    }
    
}
