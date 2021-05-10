defmodule GenReport do
  alias GenReport.Parser

  # build reads data from a file and generates a report from it
  @spec build(String.t()) :: {:error, atom()} | {:ok, map()}
  def build(filename) do
    filename
    |> Parser.parse_file()
    |> case do
      {:error, reason} ->
        {:error, reason}

      data ->
        {:ok,
         Enum.reduce(data, report_acc(), fn user, report ->
           update_report(user, report)
         end)}
    end
  end

  # build_from_many receives a list of file names (strings) and
  # returns the merged report of them. Invalid files are just ignored
  @spec build_from_many(list(String.t())) :: map()
  def build_from_many(filenames) do
    filenames
    |> Task.async_stream(&build/1)
    |> Enum.filter(fn {:ok, {flag, _}} -> flag != :error end)
    |> Enum.reduce(
      report_acc(),
      fn {:ok, {:ok, result}}, report ->
        join_reports(report, result)
      end
    )
  end

  # join_reports receives two maps (reports) and merges them. The merged report is returned
  @spec join_reports(map(), map()) :: map()
  defp join_reports(report1, report2) do
    all_hours = merge_maps(report1["all_hours"], report2["all_hours"])
    hours_per_month = merge_layered_maps(report1["hours_per_month"], report2["hours_per_month"])
    hours_per_year = merge_layered_maps(report1["hours_per_year"], report2["hours_per_year"])

    build_report(all_hours, hours_per_month, hours_per_year)
  end

  # merge_maps receives two maps and merges them. If map1 and map2 contain an equal key, that
  # key's value is the sum of it's value from map1 and map2
  @spec merge_maps(map(), map()) :: map()
  defp merge_maps(map1, map2) do
    Map.merge(map1, map2, fn _key, val1, val2 ->
      val1 + val2
    end)
  end

  # merge_layered_maps receives two maps of maps and merges the submaps
  @spec merge_layered_maps(map(), map()) :: map()
  defp merge_layered_maps(map1, map2) do
    keys = get_maps_keys(map1, map2)

    Enum.reduce(
      keys,
      %{},
      fn key, acc ->
        merged_submap =
          case check_key_existence(key, map1, map2) do
            {true, true} -> merge_maps(map1[key], map2[key])
            {false, false} -> nil
            {_, false} -> map1[key]
            {false, _} -> map2[key]
          end

        Map.put(acc, key, merged_submap)
      end
    )
  end

  # check_key_existence receives a key and two maps, and returns a tuple of
  # bool that indicates if each map contain the key
  @spec check_key_existence(String.t(), map(), map()) :: {boolean(), boolean()}
  defp check_key_existence(key, map1, map2) do
    {Map.has_key?(map1, key), Map.has_key?(map2, key)}
  end

  # get_maps_keys receives two maps an returns a list of the maps' keys
  @spec get_maps_keys(map(), map()) :: list()
  defp get_maps_keys(map1, map2) do
    map1_keys =
      Map.keys(map1)
      |> MapSet.new()

    Map.keys(map2)
    |> MapSet.new()
    |> MapSet.union(map1_keys)
    |> MapSet.to_list()
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
