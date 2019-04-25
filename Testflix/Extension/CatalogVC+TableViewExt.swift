//
//  CatalogVC+TableViewDataSource.swift
//  Testflix
//
//  Created by Victor Valfre on 14/04/19.
//  Copyright © 2019 Victor Valfre. All rights reserved.
//

import Foundation
import UIKit

//Extensao responsavel pela Tabela da tela Inicial
extension CatalogViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return generos.values.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return generos.values[section].name
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let width: CGFloat = tableView.frame.width * 0.4 // 60% do tamanho da tela
        return width * (3/4)  // aspectio ratio
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as! TableViewCell
        cell.backgroundColor = .none
        
        var moviesFromGender = [Filme]()
        if(
            indexPath.section < generos.values.count){
            moviesFromGender = generos.values[indexPath.section].movies!
        }

        cell.movies = moviesFromGender
        
        return cell
    }
    
}
