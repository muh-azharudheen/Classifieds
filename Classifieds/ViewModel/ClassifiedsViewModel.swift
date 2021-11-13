//
//  ClassifiedsViewModel.swift
//  Classifieds
//
//  Created by Muhammed Azharudheen on 13/11/2021.
//

import Foundation

class ClassifiedsViewModel {
    
    var title: String { "home.welcome.message".localized }
    
    var subTitle: String { Date().toString() }
    
    var listTitle: String { "home.listing.title".localized }
    
}

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}

private extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MMM dd EEEE"
        return formatter.string(from: self)
    }
}
