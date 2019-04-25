//
//  MovieCollectionView.swift
//  Testflix
//
//  Created by Victor Valfre on 17/04/19.
//  Copyright © 2019 Victor Valfre. All rights reserved.
//

import Foundation
import UIKit

//Classe responsavel pela collectionview dentro da table
public class MovieCollectionView: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionId = "collectionId"
    var movies : [Filme]?
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let cl = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cl.backgroundColor = .none
        
        cl.delegate = self
        cl.dataSource = self
        return cl
    }()
    
    override init() {
        super.init()
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: collectionId)
    }
    
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: collectionId, for: indexPath) as! MovieCell
        
        if(movies != nil &&
            movies!.count > 0 &&
            indexPath.row < movies!.count){
            cell.movie = movies![indexPath.row]
        }
        
        cell.backgroundColor = .none
       // cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleCellSelected(sender:))))
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width * 0.4
        return CGSize(width: width, height: width * (3/4))
    }
    
    @objc func handleCellSelected(sender: UITapGestureRecognizer){
        let cell = sender.view as! MovieCell
        //let indexPath = collectionView.indexPath(for: cell)
        print("Cliquei aqui! " + String(cell.movie!.title ?? "Filme"))
    }
}
