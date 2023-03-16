defmodule CurrencyReader do
  @moduledoc """
  Documentation for `CurrencyReader`.
  """

  alias CurrencyReader.ConvertCurrency
  alias CurrencyReader.Entities.{Currency}
  alias CurrencyReader.Storages.{LastConversions}

  def convert_currency(from_currency, to_currencies) when is_binary(from_currency) and is_list(to_currencies) do
    from = Currency.create(from_currency)
    to = to_currencies
    |> Enum.map(&(Currency.create(&1)))

    ConvertCurrency.call(from, to)
    |> handle_response()
  end
  def convert_currency(from_currency, to_currency) when is_binary(from_currency) and is_binary(to_currency) do
    convert_currency(from_currency, [to_currency])
  end
  def convert_currency(from_currency) do
    convert_currency(from_currency, [])
  end

  defp handle_response({:ok, response}) do
    LastConversions.push(response)
    IO.inspect(LastConversions.list)
  end
  defp handle_response({:error, error}) do
    IO.inspect(error)
  end
end
