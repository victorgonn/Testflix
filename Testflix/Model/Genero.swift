//
//  Genero.swift
//  Testflix
//
//  Created by Victor Valfre on 13/04/19.
//  Copyright © 2019 Victor Valfre. All rights reserved.
//

import Foundation
import UIKit

public class Generos : Codable {
    public var values: [Genero]
    
    enum CodingKeys: String, CodingKey
    {
         case values = "genres"
    }
    
    public init (){
        self.values = []
    }
    
    public func sort( asc:Bool ){
        self.values.forEach { (genero) in
            genero.sortByDate(asc: asc)
        }
    }
}


public class Genero : Codable {
    public var id: Int
    public var name: String
    public var movies: [Filme]?
    
    public init (id: Int, name: String){
        self.id = id
        self.name = name
        self.movies = []
    }
    
    enum CodingKeys: String, CodingKey
    {
        case id = "id"
        case name = "name"
    }
    
    public func loadFilmesByGenero(filmes: [Filme]){
        self.movies = filmes.filter({ (Filme) -> Bool in
            Filme.idGenero.contains(self.id)
        })
    }
    
    public func sortByDate( asc: Bool ){
        if(self.movies != nil){
            self.movies = self.movies!.sorted(by: { $0.rDate!.compare($1.rDate!) == (asc ? .orderedAscending : .orderedDescending) })
        }
    }
}
