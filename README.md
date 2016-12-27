# Cancellable dispatchAfter

One function for easy task dispatching with delay and cancelling mechanism

## Usage example

Create delayed task:
```swift
let cancelBlock = dispatchAfter(delay: 15.0, queue: dispatch_get_main_queue()) {
    someWorkHere()
}
```

Cancel anywhere before task is executed:
```swift
cancelBlock()
```

## Thanks

*Original idea source:*
https://github.com/katleta3000/CancelBlocks
Created by Evgenii Rtishchev on 16/02/15.
