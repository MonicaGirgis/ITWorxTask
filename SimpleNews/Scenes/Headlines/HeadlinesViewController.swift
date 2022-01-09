//
//  HeadlinesViewController.swift
//  SimpleNews
//
//  Created by Monica Girgis Kamel on 08/01/2022.
//

import UIKit

class HeadlinesViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var articlesTableView: UITableView!
    
    private var articlesData: APIResponse<[Article]> = APIResponse(totalResults: nil, articles: [], status: nil)
    var didSearch: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        setupUI()
    }
    
    private func setupUI(){
        navigationItem.titleView = searchBar
        articlesTableView.register(UINib(nibName: String(describing: ArticleTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ArticleTableViewCell.self))
    }
    
    private func fetchData(){
        guard let country = UserManager.shared.getSelectedCountry() else { return}
        guard !didSearch else {
            APIRoute.shared.fetchRequest(clientRequest: .Search(searchText: searchBar.text ?? ""), decodingModel: APIResponse<[Article]>.self) { [weak self] response in
                guard let self = self else { return}
                switch response{
                case .success(let data):
                    self.articlesData = data
                    self.orderByDate()
                    self.articlesTableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
            return
        }
        
        APIRoute.shared.fetchRequest(clientRequest: .GetData(country: country,categories: []), decodingModel: APIResponse<[Article]>.self) { [weak self] response in
            guard let self = self else { return}
            switch response{
            case .success(let data):
                self.articlesData = data
                self.orderByDate()
                self.articlesTableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func orderByDate(){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = "MMM d, h:mm a"
        
        for (index, article) in articlesData.articles.enumerated() {
            guard let date = dateFormatter.date(from: article.publishedAt ?? "") else { return}
            guard let newDate = newDateFormatter.date(from: newDateFormatter.string(from: date)) else { return}
            articlesData.articles[index].date = newDate
        }
        
        articlesData.articles.sort {
            if let firstDate = $0.date, let secondDate = $1.date{
                return firstDate.compare(secondDate) == .orderedDescending
            }
            return false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? webViewController, let url = sender as? String else { return}
        vc.articleURL = url
    }
}

//MARK:- UITableViewDelegate, UITableViewDataSource
extension HeadlinesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesData.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ArticleTableViewCell.self), for: indexPath) as! ArticleTableViewCell
        cell.setData(article: articlesData.articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: articlesData.articles[indexPath.row].url)
    }
}

//MARK:- UISearchBarDelegate
extension HeadlinesViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        didSearch = true
        fetchData()
    }
}
