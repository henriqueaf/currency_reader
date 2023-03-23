defmodule CurrencyReader.Presenters.Conversion do
  def to_string(conversions) when is_list(conversions) do
    Enum.map(conversions, &(__MODULE__.to_string(&1)))
    |> Enum.map_join("", &(&1))
  end

  def to_string(conversion = %CurrencyReader.Entities.Conversion{}) do
    currencies = Enum.map_join(conversion.to_currencies, ", ", fn {code, val} -> "#{code} => #{val}" end)

    """
    Conversions for #{conversion.base_currency}:
      #{currencies}
    """
  end
end
