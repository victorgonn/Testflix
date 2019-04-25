//
//  ViewController.swift
//  Testflix
//
//  Created by Victor Valfre on 13/04/19.
//  Copyright © 2019 Victor Valfre. All rights reserved.
//

import UIKit
import Alamofire

class CatalogViewController: UITableViewController {
    let cellId = "cellId"
    private let service = Service()
    public var generos: Generos = Generos()
    private let movies: Filmes = Filmes()
    
    
    public var sortByDate: Bool = false {
        didSet{
            let sortButton = UIBarButtonItem(barButtonSystemItem: self.sortByDate ? .rewind : .fastForward, target: self, action: #selector(sort))
            sortButton.tintColor = .white
            navigationItem.leftBarButtonItem = sortButton
        }
    }
    
    public var loaded: Bool = false {
        didSet{
            
            self.movies.formateDate()
            self.generos.values.forEach({ (Genero) in
               Genero.loadFilmesByGenero(filmes: self.movies.values)
            })
            generos.values = generos.values.filter({ $0.movies != nil && $0.movies!.count > 0})
            self.loadView.removeFromSuperview()
            self.tableView?.reloadData()
        }
    }
    
    
    //Componente loader
    let loadView : UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
        loader.backgroundColor = .black
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.startAnimating()
        return loader
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupLoading()
        tryFetchData()
        SetupCatalogTable()
    }
    
    private func SetupLoading(){
        guard let window = UIApplication.shared.keyWindow else {return}
        
        //adicionando loading para carregar catalog
        window.addSubview(loadView)
        window.bringSubviewToFront(loadView)
        
        window.constraint(pattern: "H:|[v0]|", views: loadView) //Alinhamento Horizontal para loadView
        window.constraint(pattern: "V:|[v0]|", views: loadView) //Alinhamento Vertical para loadView
    }
    
    
    public func tryFetchData() {
        self.service.loadAppData(){
            (retorno) in
            self.generos =  retorno
            self.loadSomeJSONDataFromPagedEndPoint(page: 1)
            //print("terminou o loading")
        };
    }
    
    private func SetupCatalogTable(){
        //navigationView
        let navigationBarWidth = (navigationController?.navigationBar.frame.width)!
        let navigationBarHeigth = (navigationController?.navigationBar.frame.height)!
        let logo = UIImageView(frame: CGRect(x: 0, y: 0, width: (navigationBarWidth * 0.6), height: navigationBarHeigth * 0.6))
        logo.image = UIImage(named: "testflix")
        logo.contentMode = .scaleAspectFit
        
        navigationItem.titleView = logo
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.isTranslucent = true
        
        let sortButton = UIBarButtonItem(barButtonSystemItem: self.sortByDate ? .rewind : .fastForward, target: self, action: #selector(sort))
        sortButton.tintColor = .white
        navigationItem.leftBarButtonItem = sortButton
        
        
        //tableView
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellId)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
        //tableView.backgroundColor = .darkGray
        tableView.separatorStyle = .none
    }
    
    @objc func sort(){
        self.sortByDate = !self.sortByDate
        self.generos.sort(asc: self.sortByDate)
        self.tableView?.reloadData()
    }

    
    func loadSomeJSONDataFromPagedEndPoint(page: Int) {
        let moviesUrl = "https://api.themoviedb.org/3/movie/upcoming?api_key=1f54bd990f1cdfb230adb312546d765d&language=pt-BR&page="
        //print("Carregando pagina :" + String(page))
        guard let urlFilmes = URL(string: moviesUrl + String(page)) else {return}
        AF.request(urlFilmes).responseDecodable(completionHandler: { (response: DataResponse<Filmes>) in
            switch response.result {
            case .success(let filmes):
                if filmes.page < filmes.total_pages {
                    self.movies.values.append(contentsOf: filmes.values)
                    self.loadSomeJSONDataFromPagedEndPoint(page: page + 1)
                } else {
                    self.parsePagedResults()
                }
                
            case .failure(let error):
                //print("erro aqui!")
                print(error.localizedDescription)
            }
        })
        
    }
    
    func parsePagedResults() {
        print(self.movies.values.count)
        self.loaded = true
    }
}
