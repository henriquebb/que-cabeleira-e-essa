//
//  TimelineViewController.swift
//  camp-diversidade
//
//  Created by Henrique Barbosa on 27/05/21.
//

import UIKit
import Kingfisher

protocol TimelinePresenting: AnyObject {
    func setTimeline(timeline: [Timeline])
}

class TimelineViewController: UIViewController {
    
    //IBOutlets

    @IBOutlet weak var yearImage: UIImageView!
    @IBOutlet weak var yearDescription: UILabel!
    @IBOutlet weak var yearsCollectionView: UICollectionView! {
        didSet {
            yearsCollectionView.delegate = self
            yearsCollectionView.dataSource = self
            yearsCollectionView.showsHorizontalScrollIndicator = false
            guard let layout = yearsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
                return
            }
            layout.scrollDirection = .horizontal
        }
    }
    
    //Variables
    
    var yearIsSelected: [Bool] = []
    var lastYearSelected: IndexPath = []
    var timelinePresenter = TimelinePresenter()
    var years: [Timeline] = []
    var cellJustLoaded = false
    
//MARK: - Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        yearIsSelected = Array(repeating: false, count: 12)
        timelinePresenter.attachView(view: self)
        timelinePresenter.getTimeline()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addFade()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//MARK: CollectionView

extension TimelineViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return years.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "YearCollectionViewCell", for: indexPath) as? YearCollectionViewCell else { return YearCollectionViewCell() }
        if cellJustLoaded {
            if let url = URL(string: years[indexPath.item].imagemMobile) {
                cell.year.textColor = UIColor(red: 0.016, green: 0, blue: 0.749, alpha: 1)
                yearImage.kf.setImage(with: url)
                yearDescription.text = years[indexPath.item].descricao
                lastYearSelected = indexPath
                cellJustLoaded = false
            }
        }
        
        if yearIsSelected[indexPath.item] {
            cell.year.textColor = UIColor(red: 0.016, green: 0, blue: 0.749, alpha: 1)
        } else {
            cell.year.textColor = UIColor(red: 0.333, green: 0.333, blue: 0.333, alpha: 1)
        }
        
        cell.year.text = String(years[indexPath.item].ano)
        return cell
    }
}

extension TimelineViewController {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as? YearCollectionViewCell
        if yearIsSelected[indexPath.item] {
            lastYearSelected = indexPath
            return
        } else {
            guard let url = URL(string: years[indexPath.item].imagemMobile) else {
                return
            }
            yearImage.kf.setImage(with: url)
            yearDescription.text = years[indexPath.item].descricao
            cell?.year.textColor = UIColor(red: 0.016, green: 0, blue: 0.749, alpha: 1)
            if lastYearSelected.count != 0 {
                let lastCell = collectionView.cellForItem(at: lastYearSelected) as? YearCollectionViewCell
                lastCell?.year.textColor = UIColor(red: 0.333, green: 0.333, blue: 0.333, alpha: 1)
                yearIsSelected[lastYearSelected.item] = false
            }
            yearIsSelected[indexPath.item] = true
        }
        lastYearSelected = indexPath
    }
}

//MARK: - TimelinePresenting

extension TimelineViewController: TimelinePresenting {
    func setTimeline(timeline: [Timeline]) {
        years = timeline
        yearIsSelected = Array(repeating: false, count: years.count)
        yearIsSelected[0] = true
        cellJustLoaded = true
        yearsCollectionView.reloadData()
    }
}

//MARK: - UI

extension TimelineViewController {
    func addFade() {
        let gradientMaskLayer = CAGradientLayer()
        gradientMaskLayer.frame = yearImage.bounds
        gradientMaskLayer.colors = [UIColor.white.cgColor, UIColor.clear.cgColor,]
        gradientMaskLayer.locations = [0.7, 1]
        yearImage.layer.mask = gradientMaskLayer
    }
}

//MARK: - TimelineCollectionViewFlowLayout

extension TimelineViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let text = String(years[indexPath.item].ano)
        
        let resultText = NSAttributedString(string: text, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17)])
        let textWidth = resultText.boundingRect(with: resultText.size(), options: .usesLineFragmentOrigin, context: nil).width
        return CGSize(width: ceil(textWidth) + 16, height: 30)
    }
}
