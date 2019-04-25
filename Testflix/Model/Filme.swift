//
//  Filme.swift
//  Testflix
//
//  Created by Victor Valfre on 13/04/19.
//  Copyright © 2019 Victor Valfre. All rights reserved.
//

import Foundation
import UIKit

public class Filmes: Codable{
    public var values: [Filme]
    public var page: Int
    public var total_pages: Int
    
    enum CodingKeys: String, CodingKey
    {
        case values = "results"
        case page = "page"
        case total_pages = "total_pages"
    }
    
    public init (){
        self.page = 0
        self.total_pages = 0
        self.values = []
    }
    
    public func formateDate(){
        self.values.forEach { (value) in
            value.formateDate()
        }
    }
}

public class Filme : Codable{
    public var voteCount: Int
    public var id: Int
    public var video: Bool
    public var voteAverage: Float
    public var title: String?
    public var popularity: Float
    public var posterPath: String?
    public var originalLanguage: String?
    public var originalTitle: String?
    public var idGenero: [Int]
    public var backDropPath: String?
    public var adult: Bool
    public var overview: String?
    public var releaseDate: String?
    public var rDate: Date?
    
    enum CodingKeys: String, CodingKey
    {
        case voteCount = "vote_count"
        case id = "id"
        case video = "video"
        case voteAverage = "vote_average"
        case title = "title"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case idGenero = "genre_ids"
        case backDropPath = "backdrop_path"
        case adult = "adult"
        case overview = "overview"
        case releaseDate = "release_date"
    }
    

    public init (voteCount: Int, id: Int, video: Bool, voteAverage: Float, title: String, popularity: Float, posterPath: String, originalLanguage: String, originalTitle: String, idGenero: [Int], backDropPath: String, adult: Bool, overview: String, releaseDate: String){
        self.voteCount = voteCount
        self.id = id
        self.video = video
        self.voteAverage = voteAverage
        self.title = title
        self.popularity = popularity
        self.posterPath = posterPath
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.idGenero = idGenero
        self.backDropPath = backDropPath
        self.adult = adult
        self.overview = overview
        self.releaseDate = releaseDate
    }
    
    public func formateDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        self.rDate = dateFormatter.date(from:self.releaseDate!)!
    }
}
