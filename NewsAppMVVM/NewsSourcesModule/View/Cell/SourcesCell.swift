//
//  SourcesCell.swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 12.12.2021.
//

import UIKit

class SourcesCell: UICollectionViewCell {
    static var identifier = "SourceCell"
    @IBOutlet weak var sourceName: UILabel!
    @IBOutlet weak var sourceCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        makeCellBackground()
        configureShadowLayer()
        configSourceNameLabel()
    }
    
    func updateCell(sourceName: String, sourceCategory: String) {
        self.sourceName.text = sourceName
        self.sourceCategory.text = sourceCategory
    }
    
    private func configureShadowLayer() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.6
        layer.masksToBounds = false
    }
    
    private func makeCellBackground() {
        let view = UIView(frame: self.bounds)
        view.createGradient(firstColor: .firstSourceCellBack, secondColor: .secondSourceCellBack, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1), isAnimated: false, finalGradien: nil)
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 0.8
        view.layer.borderColor = UIColor.sourceCellBorderColor.cgColor
        view.clipsToBounds = true
        backgroundView = view
    }
    
    private func configSourceNameLabel() {
        sourceName.adjustsFontSizeToFitWidth = true
        sourceName.lineBreakMode = .byWordWrapping
    }
}
