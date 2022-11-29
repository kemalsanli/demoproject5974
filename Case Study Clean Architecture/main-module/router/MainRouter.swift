//
//  MainRouter.swift
//  Case Study Clean Architecture
//
//  Created by Kemal Sanli on 26.11.2022.
//

import Foundation

final class MainRouter : PresenterToRouterMainProtocol {
    static func createModule(ref: MainViewController) {
        let presenter : ViewToPresenterMainProtocol & InteractorToPresenterMainProtocol = MainPresenter()
        
        //View controller
        ref.MainPresenter = presenter
        
        //Presenter
        ref.MainPresenter?.MainInteractor = MainInteractor()
        ref.MainPresenter?.MainView = ref
        
        //Interactor
        ref.MainPresenter?.MainInteractor?.MainPresenter = presenter
    }
}
