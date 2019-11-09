import RxSwift
import RxCocoa
import Foundation

print("main start")

let firstObservable = PublishRelay<String?>()
let secondObservable = BehaviorRelay<Int>(value: 100)

firstObservable.flatMap(Observable.from(optional:))
  .subscribe(onNext: { str in
    print(str)
  })

secondObservable.map { int in int * 200 }
  .subscribe(onNext: { int in
    print(int)
  })

firstObservable.accept("before nil")
firstObservable.accept(nil)
firstObservable.accept("after nil")
secondObservable.accept(5)

print("main end")
