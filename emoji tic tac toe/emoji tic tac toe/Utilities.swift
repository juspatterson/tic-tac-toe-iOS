func with<T>(_ it: T, do: (T) -> Void) -> T where T: AnyObject { `do`(it) ; return it }

func withValue<T>(_ it: T, do: (inout T) -> Void) -> T {
    var mutableIt = it
    `do`(&mutableIt)
    return mutableIt
}
