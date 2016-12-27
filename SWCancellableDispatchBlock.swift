//
//  SWCancellableDispatchBlock.swift
//  Created by Hryhorii Maksiuk on 12/21/16.
//
//  Idea taken from https://github.com/katleta3000/CancelBlocks repository
//  Created by Evgenii Rtishchev on 16/02/15.
//

typealias DispatchCancelBlock = (() -> Void)

func dispatchAfter(delay: Double, queue: dispatch_queue_t, block originalBlock: dispatch_block_t) -> DispatchCancelBlock {
    
    typealias dispatch_cancelable_block_t = (cancelled: Bool) -> (Void)
    
    var cancellableBlock: dispatch_cancelable_block_t? = nil
    let delayBlock: dispatch_cancelable_block_t = { (cancel:Bool) -> Void in
        if cancel == false {
            dispatch_async(queue, originalBlock)
        }
        cancellableBlock = nil
    }
    
    cancellableBlock = delayBlock
    let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
    dispatch_after(time, queue) {
        cancellableBlock?(cancelled: false)
    }
    
    return { cancellableBlock?(cancelled: true) }
}
