//
//  BookmarksViewController.swift
//  SimpleNews
//
//  Created by Monica Girgis Kamel on 09/01/2022.
//

import UIKit

class BookmarksViewController: UIViewController {

    @IBOutlet weak var bookmarksTableView: UITableView!
    
    private var articles: [FavoriteArticles] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        fetchData()
    }
    
    private func setupUI(){
        bookmarksTableView.register(UINib(nibName: String(describing: ArticleTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ArticleTableViewCell.self))
    }
    
    private func fetchData(){
        guard let articles = CoreDataManager.shared.getArticles() else { return}
        self.articles = articles
    }
    
    @IBAction func deleteArticles(_ sender: Any) {
        CoreDataManager.shared.removeAllArticles()
        articles.removeAll()
        bookmarksTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? webViewController, let url = sender as? String else { return}
        vc.articleURL = url
    }
}

//MARK:- UITableViewDelegate, UITableViewDataSource
extension BookmarksViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ArticleTableViewCell.self), for: indexPath) as! ArticleTableViewCell
        cell.setData(article: articles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetails", sender: articles[indexPath.row].url)
    }
}
