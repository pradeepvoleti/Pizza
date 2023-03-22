//
//  ViewModel.swift
//  Pizza
//
//  Created by Ram Voleti on 20/01/21.
//

import Foundation

protocol ViewModelType {
    
}

class ViewModel {

    var showLoader: Dynamic<Bool> = Dynamic(false)
    var showError: Dynamic<Error> = Dynamic(NetworkError.temp)
    var reload: Dynamic<Bool> = Dynamic(false)
    
    let url = "https://raw.githubusercontent.com/RajendraNayak/Test/main/foodList.json"
    var model: Pizza?
    
    var noOfSections: Int {
        model?.categoryData.count ?? 0 + 1
    }
    
    
    func populate() {
        showLoader.value = true
        Network.response(for: url, type: Pizza.self) { [weak self] model in
            self?.showLoader.value = false
            self?.model = model
            self?.reload.value = true
            print(model)
        } failure: { [weak self] error in
            self?.showLoader.value = false
            self?.showError.value = error
            print(error)
        }
    }
    
    func bannerInfo(at index: Int) -> String {
        guard let banners = model?.banner else {
            return ""
        }
        
        if index < banners.count {
            return banners[index]
        }
        return ""
    }
    
    
}
