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
  .map { str in
    str + " from cold observable"
  }

let coldSecondObservable = secondObservable
  .map { int -> String in
    print("in cold observable")
    print("you got \(int), but never reterned")
    print("this closure will be called for each subscriber")
    return "This is return value"
   }

let coldSharedSecondObservable = secondObservable
  .map { int -> String in
    print("in cold shared observable")
    print("this closure will be called only once")
    return "This is return value from shared"
   }
   .share()

firstObservable.flatMap(Observable.from(optional:))
  .subscribe(onNext: { str in
    print(str)
  })

secondObservable.map { int in int * 200 }
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

secondObservable.accept(5)
secondObservable.accept(12)

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
    print(str)
  })

coldSharedSecondObservable
  .subscribe(onNext: { str in
    print(str)
  })

secondObservable.accept(100)
secondObservable.accept(40)
secondObservable.accept(2)

print("main end")
