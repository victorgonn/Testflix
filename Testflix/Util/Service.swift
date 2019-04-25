//
//  Service.swift
//  Testflix
//
//  Created by Victor Valfre on 14/04/19.
//  Copyright © 2019 Victor Valfre. All rights reserved.
//

import Foundation
import Alamofire

//Classe para resolver chamadas REST
struct Service {
    
    static let shared = Service()
    
    private let categoryUrl = "https://api.themoviedb.org/3/genre/movie/list?api_key=1f54bd990f1cdfb230adb312546d765d&language=pt-BR"
    private let moviesUrl = "https://api.themoviedb.org/3/movie/upcoming?api_key=1f54bd990f1cdfb230adb312546d765d&language=pt-BR&page="
    
    public func loadAppData(completionBlock: @escaping (Generos) -> Void) -> Void{
        guard let urlCategorias = URL(string: categoryUrl) else {return}
        
        AF.request(urlCategorias).responseDecodable(completionHandler: { (response: DataResponse<Generos>) in
                switch response.result {
                case .success(let generos):
                    do {
//                        self.loadMoviesData(){
//                            (todosFilmes) in
//
//                            print(todosFilmes!.page)
//                            print(todosFilmes!.total_pages)
//
//                            todosFilmes?.formateDate()
//                            generos.values.forEach({ (Genero) in
//                                Genero.loadFilmesByGenero(filmes: todosFilmes!.values)
//                            })
//
//                            generos.values = generos.values.filter({ $0.movies != nil && $0.movies!.count > 0})
//                        }
                        completionBlock(generos)
                    }
                    
                //Erro de parser
                case .failure(let error):
                    print(error.localizedDescription)
                    completionBlock(Generos())
                }
        })
    }
    
    
    func loadMoviesData(completionBlock: @escaping (Filmes?) -> Void) -> Void
    {
        guard let urlFilmes = URL(string: moviesUrl + "1") else {return}
        AF.request(urlFilmes).responseDecodable(completionHandler: { (response: DataResponse<Filmes>) in
            switch response.result {
            case .success(let filmes):
                completionBlock(filmes)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}
