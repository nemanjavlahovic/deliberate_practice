### Meaningful Names
- For example, hp, aix and sco would be poor variable names because they are the names of Unix platforms or variants. Even if you are coding a hypotenuse and hp looks like a good abbreviation, it could be disinformative.
- Noise words are another meaningless distinction. Imagine that you have a `Product` class. If you have another called `ProductInfo` or `ProductData`, you have made the names different without making them mean anything different. `Info` and `Data` are indistinct noise words like `a`, `and` and `the`.
- Single-letter names and numeric constants have a particular problem in that they are not easy to locate across a body of text.


### Functions
- The ideal number of arguments for a function is zero (niladic). Next comes one (monadic), followed closely by two (dyadic). Three arguments (triadic) should be avoided where possible. More than three (polyadic) requires very special justification and they should not be used.
- Flag arguments are ugly. Passing a boolean into a function is a bad practice and it immediately complicates the signature of the method, loudly proclaiming that this function does more than one thing. It does one if the flag is true and another if the flag is false.
-  Extract try/catch blocks into functions of their own.

### Formatting
- If one function calls another, they should be vertically close and the caller should be above the callee, if possible.
- In general we want function call dependencies to point in the downward direction. That is, a function that is called should be below a function that does the calling. This creates a nice flow down the source code module from high level to low level.

## Breaking Indentation
- It is sometimes tempting to break the indentation rule for short if, guard statements, but you should prefer to expand and indent the scopes instead, preferably like this:
```
guard let variable = variable else {
  return 
}
```

### Boundaries
- Reduce the amount of third-party calls by having a very few places in the code that refer to them. Wrap them into a class and make all calls from a single place.
