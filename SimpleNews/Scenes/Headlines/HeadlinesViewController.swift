//
//  HeadlinesViewController.swift
//  SimpleNews
//
//  Created by Monica Girgis Kamel on 08/01/2022.
//

import UIKit

class HeadlinesViewController: UIViewController {

    @IBOutlet weak var articlesTableView: UITableView!
    
    private var articlesData: APIResponse<[Article]> = APIResponse(totalResults: nil, articles: [], status: nil)
    private var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
        setupUI()
    }
    
    private func setupUI(){
        articlesTableView.register(UINib(nibName: String(describing: ArticleTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ArticleTableViewCell.self))
    }

    private func fetchData(){
        APIRoute.shared.fetchRequest(clientRequest: .GetData(country: .UnitedStates), decodingModel: APIResponse<[Article]>.self) { [weak self] response in
            guard let self = self else { return}
            switch response{
            case .success(let data):
                if self.page == 1{
                    self.articlesData = data
                }else{
                    self.articlesData.articles.append(contentsOf: data.articles)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK:- UITableViewDelegate, UITableViewDataSource
extension HeadlinesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesData.articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ArticleTableViewCell.self), for: indexPath) as! ArticleTableViewCell
        return cell
    }
}
