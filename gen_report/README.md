# GenReport

Implements function that reads employees worked hours data from `.csv` files and generates a report based on them.  
Each line of the `.csv` files should be in the following format:  
`name,hours_worked,day,month,year`  
Where all the columns but "name" are numbers.

**Be sure that the `.csv` files are inside `/reports` folder. Also, when calling the `build` function to generate the report, there's no need to specify the `.csv` file extension**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `gen_report` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:gen_report, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/gen_report](https://hexdocs.pm/gen_report).
