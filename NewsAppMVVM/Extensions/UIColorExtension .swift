//
//  UIColorExtension .swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 13.12.2021.
//

import Foundation
import UIKit


extension UIColor {
    //MARK: - Main background
    //цвета градиента фона сразу после запуска приложения
    static var startFirstMainBack: UIColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)  // { #colorLiteral }
    static var startSecondMainBack: UIColor = #colorLiteral(red: 0.9218977094, green: 0.6514603496, blue: 0.6022174358, alpha: 1)
    //конечные цвета градиента фона приложения
    static var firstMainBack: UIColor = #colorLiteral(red: 0.9765617251, green: 0.9530979991, blue: 0.9295695424, alpha: 1)
    static var secondMainBack: UIColor = #colorLiteral(red: 0.941300869, green: 0.7532756925, blue: 0.7459537387, alpha: 1)
    
    //MARK: - SourceCell
    static var sourceCellBorderColor: UIColor = #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
    
    static var firstSourceCellBack: UIColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    static var secondSourceCellBack: UIColor = #colorLiteral(red: 0.9450269341, green: 0.9566741586, blue: 0.8268028498, alpha: 1)
}
