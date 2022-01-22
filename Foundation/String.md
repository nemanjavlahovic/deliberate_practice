### String

- if you are using:

```
strings.sort { $0 < $1 }
```

There's a good chance you want to be using:

```
strings.sort {
  $0.localizedStandardCompare($1) == .orderedAscending
}
```
instead. The latter correctly handles numbers and mixed case, e.g. by putting "foo10" after foo9".
