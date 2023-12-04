# Ignite Elixir

This is the repository for my resolutions of [Rocketseat's](https://rocketseat.com.br/) Ignite classes and challenges of the Elixir trail.  

- [Official docs](https://hexdocs.pm/elixir)
- Command `iex` starts elixir interactively
    - `iex -S mix` to run with locally defined modules
- Division:
    - 5 / 2 => 2.5 (float)
    - div(5,2) => 2 (int)
- String interpolation:
    ```
    x = "some"
    y = "#{x}thing"
    ```
- Modules always start with uppercase letters (e.g. "String")
    - Calling a module function with "h" before it shows help menu
        - `h String.slice`
- Variable reassignment creates a new memory address (doesn't replace the current one)
- Atom = constant string w/ value equals to the name (e.g. `:banana`)
    - `:ok, :error, :true, :false`
- Anonymous function:
    - Creation: `multp = fn a, b -> a * b end`
    - Usage: `multp.(2,3)`
- Lists:
    - Are actually linked lists (`[1, 2, 3]` == "[1] => [2] => [3]")
        - Dynamic size
    - Not possible to access a list item using its index directly (`x[0]`)
    - Join lists using `++` (`[1, 2] ++ [3, 4] == [1, 2, 3, 4]`)
    - Remove matching elements from lists using `--` (`[1, 2, 3] -- [2] == [1, 3]`)
    - Get list first element (head) using `hd([1, 2, 3]) == 1`
    - Get list tail using `tl([1, 2, 3]) == [2, 3]`
- Tuples:
    - Stored sequentially in memory (`{1, 2 ,3}` == "[1, 2, 3]")
        - Static size
    - Not possible to access a list item using its index directly (`x[0]`)
        - Use `elem(<tuple>, <index>)`
    - Commonly used as return value of functions
        - `{:ok, "content"}`
        - `{:error, :errtype}`
- Maps:
    - Can be created using atoms or strings as keys
        - `%{a: 1, b: 2, c: 3}`
        - `%{"a" => 1, "b" => 2, "c" => 3}`
        - If created with atoms, can access values using either `mymap.key` or `mymap[key]`
        - If created with strings, can only access values with `mymap[key]`
    - `Map.put(<map>, <key>, <value>)` adds new key-value pair or alter existing one
    - `%{<map> | <key> <value>}` alters existing value associated with the key
- Pattern matching
    - `=` is a matching operator
    - Examples:
        - `[a, b, c] = [1, 2 ,3]`
            - `a == 1`, `b == 2`, `c == 3`
        - `[head | tail] = [1, 2, 3]`
            - `head == 1` and `tail == [2, 3]`
        - `[head | _] = [1, 2, 3]`
            - `head == 1`
        - `%{a: val1, b: val2} = %{a: 1, b: 2}`
            - `val1 == 1` and `val2 == 2`
        - `%{a: val1} = %{a: 1, b: 2}`
            - `val1 == 1`
        - `{:ok, content} = {:ok, "text from a file"}`
            - `content == "text from a file"`
    - It's possible to pin a variable, making it not reassignable
        ```
        x = 2   // ok
        x = 3   // ok
        ^x = 4  // not ok, MatchError
        ^x = 2  // not ok, MatchError
        ```

    - Anonymous function with pattern matching:
        ```
            read_file = fn
                {:ok, content} -> "Success #{content}"
                {:error, reason} -> "Error #{reason}"
            end
            
            read_file.(File.read("filename"))
        ```
- Functions:
    - Private functions in a module => `defp`
    - Public functions in a module => `def`
    - One-line declaration => `def sum([], acc), do: acc`
    - [Tail Call Optimization](https://efficient-sloth-d85.notion.site/Recursividade-e-Tail-Call-Optimization-79f2a8103b174d6db58d8bea19546c0d)
    - Functions with `?` return boolean values (`is_even?`)