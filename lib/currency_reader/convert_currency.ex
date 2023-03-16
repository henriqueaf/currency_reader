defmodule CurrencyReader.ConvertCurrency do
  alias CurrencyReader.Entities.Currency
  alias CurrencyReader.ApiClients.FreeCurrencyApi

  def call(%Currency{} = base_currency), do: call(base_currency, [])
  def call(%Currency{} = base_currency, to_currencies) when is_list(to_currencies) do
    filtered_to_currencies = filter_only_currencies(to_currencies)

    FreeCurrencyApi.request_currency_convertion(base_currency, filtered_to_currencies)
    |> handle_response(base_currency)
  end

  defp filter_only_currencies(list) do
    list |> Enum.filter(&match?(%Currency{}, &1))
  end

  defp handle_response({:ok, response}, base_currency), do: {:ok, %{base_currency.code => response}}
  defp handle_response({:error, error}, _), do: {:error, error}
end
