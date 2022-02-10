//
//  DictionaryExtension .swift
//  NewsAppMVVM
//
//  Created by Иван Тиминский on 21.12.2021.
//

import Foundation

extension Dictionary {
    mutating func merge(with dictionary: Dictionary) {
        for element in dictionary {
            updateValue(element.value, forKey: element.key)
        }
    }
    
    func createURLPath(keyOfLastParameter: String? ) -> String where Key == String, Value == String {
        
        var lastParameterToTheEnd: String = ""
        var inputParameters = self   // mutating
        var srtingURLParamPath: String = "?"
        
        if let lastParameter = keyOfLastParameter {  // последний будет apiKey ( можно было заменить на .count == iteration)
            for parameter in self {
                if parameter.key == lastParameter {
                    lastParameterToTheEnd = parameter.value  // apiKey - lastParameter
                    inputParameters.removeValue(forKey: lastParameter)
                }
            }
        }
        
        
        for parameter in inputParameters {
            srtingURLParamPath += "\(parameter.key)=\(parameter.value)&"
        }
        
        if let keyOfLastParameter = keyOfLastParameter {
            return "\(srtingURLParamPath)\(keyOfLastParameter)=\(lastParameterToTheEnd)"
        } else {
            return srtingURLParamPath
        }
    }
}
