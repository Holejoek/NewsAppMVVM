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
        self.backgroundView = makeBackground()
        configureShadowLayer()
    }
//    override func draw(_ rect: CGRect) {
//        configureShadowLayer()
//    }
    func updateCell(sourceName: String, sourceCategory: String) {
        self.sourceName.text = sourceName
        self.sourceCategory.text = sourceCategory
    }
     
    private func configureShadowLayer() {
        self.layer.cornerRadius = 35
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.sourceCellBorderColor.cgColor
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 1
        self.layer.masksToBounds = true
    }
    
    private func makeBackground() -> UIView {
        let view = UIView(frame: self.bounds)
        view.createGradient(firstColor: .firstSourceCellBack, secondColor: .secondSourceCellBack, startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 0, y: 1), isAnimated: false, finalGradien: nil)
        return view
    }
    
}
