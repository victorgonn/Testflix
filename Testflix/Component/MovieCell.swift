//
//  MovieCell.swift
//  Testflix
//
//  Created by Victor Valfre on 17/04/19.
//  Copyright © 2019 Victor Valfre. All rights reserved.
//

import Foundation
import UIKit

//Classe responsavel por cada item dentro da colecao da linha da tabela
public class MovieCell: UICollectionViewCell {
    private let imageBaseUrl = "https://image.tmdb.org/t/p/w185"
    
    var movie: Filme? {
        didSet{
            titleLabel.text = movie?.title
            if(movie != nil){
                let url = movie!.posterPath != nil ? imageBaseUrl + movie!.posterPath! : ""
                if let imgUrl = URL(string: url) {
                     imageView.load(url: imgUrl)
                }
            }
            
        }
    }
    
    let imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = UIView.ContentMode.scaleToFill
        img.clipsToBounds =  true
        //img.backgroundColor = .red
        return img
    }()
    
    let titleLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 14)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(){
        addSubview(imageView)
        constraint(pattern: "H:|[v0]|", views: imageView)
        constraint(pattern: "V:|[v0]|", views: imageView)
        
        addSubview(titleLabel)
        constraint(pattern: "H:|[v0]|", views: titleLabel)
        constraint(pattern: "V:[v0(40)]|", views: titleLabel)
    }
    
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
