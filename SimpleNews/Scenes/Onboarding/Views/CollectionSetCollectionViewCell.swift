//
//  CollectionSetCollectionViewCell.swift
//  SimpleNews
//
//  Created by Monica Girgis Kamel on 08/01/2022.
//

import UIKit

class CollectionSetCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var setCollectionView: UICollectionView!
    
    var sectionName: OnboardingViewController.SectionHeaders = .Countries
    var typeDidSelect: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI(){
        setCollectionView.register(UINib(nibName: String(describing: CountryCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: CountryCollectionViewCell.self))
        
    }
    
    func setData(){
        
    }
}


//MARK:- UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension CollectionSetCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch sectionName{
        case .Countries:
            return 20
        default:
            return 20
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: CountryCollectionViewCell.self), for: indexPath) as! CountryCollectionViewCell
        switch sectionName{
        case .Countries:
            cell.setCountryTitle("United States")
        default:
           break
        }
        
        cell.typeSelected = { [weak self] in
            self?.typeDidSelect?()
        }
        return cell
    }
    
    
}
