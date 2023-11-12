// 
//  QuizViewModel.swift
//  Quiz_SwiftUI
//
//  Created by MasayaNakakuki on 2023/06/25.
//

//import RxSwift
//import RxCocoa

protocol QuizViewModelInputs: AnyObject {

}

protocol QuizViewModelOutputs: AnyObject {

}

protocol QuizViewModelType: AnyObject {
    var inputs: QuizViewModelInputs { get }
    var outputs: QuizViewModelOutputs { get }
}

final class QuizViewModel: QuizViewModelType, QuizViewModelInputs, QuizViewModelOutputs {

    var inputs: QuizViewModelInputs { return self }
    var outputs: QuizViewModelOutputs { return self }

    // private let disposeBag = DisposeBag()

    init() {
        
    }

}
