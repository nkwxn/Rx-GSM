//
//  BrandsViewModel.swift
//  Rx GSM
//
//  Created by Nicholas on 08/04/22.
//

import Foundation
import RxSwift

class BrandsViewModel {
    var allBrands = [Brand]()
    var brandsList = PublishSubject<[Brand]>()
    var searchQuery = BehaviorSubject<String>(value: "")
    var isLoaded = BehaviorSubject<Bool>(value: false)
    
    func fetchBrandsList() {
        APIRequest.fetchBrands { [weak self] brands, error in
            self?.allBrands = brands
            self?.brandsList.onNext(brands)
            self?.isLoaded.onNext(true)
        }
    }
    
    func searchPhone(query: String) {
        brandsList.onNext(query.isEmpty ? allBrands : allBrands.filter({
            $0.brandName.lowercased().contains(query.lowercased())
        }))
    }
}
