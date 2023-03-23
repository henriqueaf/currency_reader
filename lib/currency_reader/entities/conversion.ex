defmodule CurrencyReader.Entities.Conversion do
  @enforce_keys [:base_currency, :to_currencies]
  defstruct [:base_currency, :to_currencies]

  def create(conversions_list) when is_list(conversions_list) do
    Enum.map(conversions_list, &(__MODULE__.create(&1)))
  end

  def create(conversion_map = %{}) do
    Enum.map(conversion_map, fn {k, v} ->
      %__MODULE__{base_currency: k, to_currencies: v}
    end)
  end
end
