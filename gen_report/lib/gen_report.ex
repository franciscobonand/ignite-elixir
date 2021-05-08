defmodule GenReport do
  alias GenReport.Parser

  # build reads data from a file and generates a report from it
  @spec build(String.t()) :: list
  def build(filename) do
    filename
    |> Parser.parse_file()
    |> case do
      {:error, reason} ->
        {:error, reason}

      data ->
        Enum.reduce(data, report_acc(), fn user, report ->
          update_report(user, report)
        end)
    end
  end

  # update_report receives a list containing a person's data and a map (the report).
  # It returns a new report that now contains the data given in the list
  @spec update_report(list(), map()) :: map()
  defp update_report([name, hr, _, month, year], report) do
    all_hours = add_value_to_map_field(report["all_hours"], name, hr)
    hours_per_month = sum_hours_per_field(report["hours_per_month"], name, hr, month)
    hours_per_year = sum_hours_per_field(report["hours_per_year"], name, hr, year)

    build_report(all_hours, hours_per_month, hours_per_year)
  end

  # sum_hours_per_field receives a map of maps, a key of the first map, a key of one of
  # the inner maps and a number. It returns a new map of maps, in which the value specified
  # by the set of keys is updated (old value added by the new one)
  @spec sum_hours_per_field(map(), String.t(), number(), String.t()) :: map()
  defp sum_hours_per_field(per_field_report, pers_name, hrs, field) do
    pers_report =
      get_specific_map_value(per_field_report, pers_name)
      |> add_value_to_map_field(field, hrs)

    Map.put(per_field_report, pers_name, pers_report)
  end

  # add_value_to_map_field returns a new map containing given {key:value} pair
  @spec add_value_to_map_field(map(), String.t(), any()) :: map()
  defp add_value_to_map_field(map, field, value) do
    Map.put(map, field, add_value(value, map[field]))
  end

  # add_value receives two values and return their sum. If the second value is nil,
  # it returns only the first value
  @spec add_value(number(), number() | none()) :: number()
  defp add_value(value, current_total) do
    if current_total == nil,
      do: value,
      else: current_total + value
  end

  # get_specific_map_value receives a map and a key. If the map contains the key,
  # it's value is returned. Otherwise, the key is inserted in the map, and it's
  # value (an empty map) is returned
  @spec get_specific_map_value(map(), String.t()) :: map()
  defp get_specific_map_value(map, key) do
    if Map.has_key?(map, key),
      do: map[key],
      else:
        Map.put(map, key, %{})
        |> (fn new_map -> new_map[key] end).()
  end

  # report_acc returns empty report to be used as reduce accumulator
  @spec report_acc() :: map()
  defp report_acc() do
    %{
      "all_hours" => %{},
      "hours_per_month" => %{},
      "hours_per_year" => %{}
    }
  end

  # build_report receives three maps and returns a new map
  # that cointains the given maps
  @spec build_report(map(), map(), map()) :: map()
  defp build_report(total, per_month, per_year) do
    %{
      "all_hours" => total,
      "hours_per_month" => per_month,
      "hours_per_year" => per_year
    }
  end
end
