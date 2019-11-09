import RxSwift
import RxCocoa
import Foundation

print("main start")

// These are Hold Observables
let firstObservable = PublishRelay<String?>()
let secondObservable = BehaviorRelay<Int>(value: 100)

// Generate Cold Observables from Hot Observables
let coldFirstObservable = firstObservable
  .flatMap(Observable.from(optional:))
  .map { str -> String in
    print("in cold first observable")
    return str + " from cold first observable"
  }

let coldSecondObservable = secondObservable
  .map { int -> String in
    print("in cold observable, you got \(int)")
    return "This is return value with \(int)"
   }

let coldSharedSecondObservable = secondObservable
  .map { int -> String in
    print("in cold shared observable, you got \(int)")
    return "This is return value from shared with \(int)"
   }
   .share()

firstObservable
  .subscribe(onNext: { str in
    guard let result = str else {
      print("got nil")
      return
    }
    print(result)
  })

secondObservable
  .subscribe(onNext: { int in
    print(int)
  })

firstObservable.accept("before nil")

coldFirstObservable
  .subscribe(onNext: { str in
    print(str)
  })

firstObservable.accept(nil)
firstObservable.accept("after nil")
firstObservable.accept("after nil2")

secondObservable.accept(5)

coldSecondObservable
  .subscribe(onNext: { str in
    print(str)
  })
coldSecondObservable
  .subscribe(onNext: { str in
    print(str)
  })

coldSharedSecondObservable
  .subscribe(onNext: { str in
    print("subscriber1, got \(str)")
  })

coldSharedSecondObservable
  .subscribe(onNext: { str in
    print("subscriber2, got \(str)")
  })

secondObservable.accept(20)

print("main end")
