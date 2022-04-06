//
//  PhoneGalleryViewModel.swift
//  Rx GSM
//
//  Created by Nicholas on 27/03/22.
//

import RxSwift

class PhoneGalleryViewModel {
    var isLoadingHidden = BehaviorSubject<Bool>(value: false)
    var latestDevices = PublishSubject<[Phone]>()
    
    func fetchPhoneData() {
        APIRequest.fetchLatestPhones { [weak self] phoneData, errorMsg in
            self?.isLoadingHidden.onNext(true)
            self?.latestDevices.onNext(phoneData)
        }
    }
}
