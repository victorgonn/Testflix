//
//  TableViewCell.swift
//  Testflix
//
//  Created by Victor Valfre on 17/04/19.
//  Copyright © 2019 Victor Valfre. All rights reserved.
//

import Foundation
import UIKit

//Classe responsavel por cada Linha da Tabela
public class TableViewCell: UITableViewCell{
    
    var movies: [Filme]? {
        didSet{
            mCollectionView.movies = movies
        }
    }
    
    let mCollectionView: MovieCollectionView = {
        return MovieCollectionView()
    }()
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        addSubview(mCollectionView.collectionView)
        constraint(pattern: "H:|-5-[v0]-5-|", views: mCollectionView.collectionView) //Alinhamento Horizontal para Linha de Favoritos
        constraint(pattern: "V:|[v0]|", views: mCollectionView.collectionView) //Alinhamento Vertical para Linha de Favoritos
    }
    
}
