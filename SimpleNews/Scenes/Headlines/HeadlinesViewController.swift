//
//  HeadlinesViewController.swift
//  SimpleNews
//
//  Created by Monica Girgis Kamel on 08/01/2022.
//

import UIKit

class HeadlinesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
    }
    
    private var articles: [Article] = []

    private func fetchData(){
        APIRoute.shared.fetchRequest(clientRequest: .GetData(country: .UnitedStates), decodingModel: APIResponse<[Article]>.self) { [weak self] response in
            switch response{
            case .success(let data):
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK:-
extension HeadlinesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
