defmodule CurrencyReader.Presenters.Conversion do
  alias CurrencyReader.Presenters.Conversion

  def to_string(conversion_maps) when is_list(conversion_maps) do
    Enum.map(conversion_maps, &(Conversion.to_string(&1)))
    |> Enum.map_join("", &(&1))
  end

  def to_string(conversion_map = %{}) do
    Map.keys(conversion_map)
    |> Enum.map(&(to_string(&1, conversion_map)))
    |> List.first()
  end

  defp to_string(key, conversion_map = %{}) when is_binary(key) do
    currencies = Enum.map_join(conversion_map[key], ", ", fn {code, val} -> "#{code} => #{val}" end)

    """
    Conversions for #{key}:
      #{currencies}
    """
  end
end
