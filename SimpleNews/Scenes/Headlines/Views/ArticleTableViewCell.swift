//
//  ArticleTableViewCell.swift
//  SimpleNews
//
//  Created by Monica Girgis Kamel on 08/01/2022.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var headLineLabel: UILabel!
    @IBOutlet weak var newsPaperLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var datePostedLabel: UILabel!
    @IBOutlet weak var saveLaterButton: UIButton!
    
    var saveLater: (()->())?
    private var article: Article?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    private func setupUI(){
        articleImageView.makeRoundedCornersWith(radius: 8.0)
    }
    
    func setData(article: Article){
        self.article = article
        articleImageView.kf.setImage(with: URL(string: article.urlToImage ?? ""),placeholder: UIImage(systemName: "questionmark"))
        headLineLabel.text = article.title ?? ""
        newsPaperLabel.text = article.source?.name ?? ""
        descriptionLabel.text = article.articleDescription ?? ""
        datePostedLabel.text = setData(date: article.date ?? Date())
        saveLaterButton.setImage((article.isSaved ?? false) ? UIImage(systemName: "bookmark.fill") : UIImage(systemName: "bookmark"), for: .normal)
    }
    
    func setData(article: FavoriteArticles){
        articleImageView.kf.setImage(with: URL(string: article.urlToImage ?? ""),placeholder: UIImage(systemName: "questionmark"))
        headLineLabel.text = article.title ?? ""
        newsPaperLabel.text = article.source ?? ""
        descriptionLabel.text = article.desc ?? ""
        datePostedLabel.text = setData(date: article.date ?? Date())
        saveLaterButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
    }
    
    private func setData(date: Date)->String{
        let newDateFormatter = DateFormatter()
        newDateFormatter.dateFormat = "MMM d, h:mm a"
        return newDateFormatter.string(from: date)
    }
    
    @IBAction func saveLaterAction(_ sender: Any) {
        guard let article = article, !(article.isSaved ?? false) else {
            return
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveLinear) { [weak self] in
            self?.saveLaterButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
            
        } completion: { finished in
            if finished{
                self.saveLater?()
            }
        }
        
    }
}
