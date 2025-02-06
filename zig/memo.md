# pointer types in zig

empty cell means **No**

| feature       | pointer `*T`     | many item pointer `*[N]T` | c style pointer `[*]T`    | slice `[]T`             |
| :------------ | :--------------- | :------------------------ | :------------------------ | :---------------------- |
| dereference   | `ptr.*`          |                           |                           |                         |
| indexable     |                  | yes                       | yes                       | yes                     |
| sliceable     |                  | yes                       | yes                       | yes                     |
| element count | 1                | compile time known        | unknown                   | runtime known           |
| arithetic     |                  |                           | i.e. `ptr + 1`, `ptr - 1` |                         |
| size          | `@sizeOf(usize)` | `@sizeOf(usize)`          | `@sizeOf(usize)`          | `@sizeOf(usize) * 2`    |
| attributes    | yes              | yes                       | yes                       | yes                     |
| use case      | reference        | accessing static array    | interfacing with C        | safe array manipulation |
