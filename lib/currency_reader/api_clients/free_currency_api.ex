defmodule CurrencyReader.ApiClients.FreeCurrencyApi do
  alias CurrencyReader.Entities.Currency
  alias CurrencyReader.ApiClients.{Base}

  use Base

  defp api_url, do: Application.get_env(:currency_reader, :currency_api_url)
  defp api_key, do: Application.get_env(:currency_reader, :currency_api_key)

  def request_currency_convertion(%Currency{} = base_currency, to_currencies) when is_list(to_currencies) do
    base_currency
    |> build_url(to_currencies)
    |> make_request()
  end

  defp build_url(%Currency{} = base_currency, to_currencies) when is_list(to_currencies) do
    currencies_string = to_currencies
    |> Enum.map(fn currency -> currency.code end)
    |> Enum.join(",")

    "#{api_url()}?base_currency=#{base_currency.code}&currencies=#{currencies_string}"
  end

  defp make_request(url) when is_binary(url) do
    headers = [{'apikey', api_key()}]

    :httpc.request(:get, {url, headers}, http_request_opts(), [])
    |> handle_http_response()
  end

  defp handle_http_response({response_status, response}) do
    {_http_status_line, _http_headers, http_body_response} = response
    {:ok, json_response} = Jason.decode(http_body_response)

    case response_status do
      :ok -> handle_ok_response(json_response)
      :error -> {:error, json_response}
    end
  end

  defp handle_ok_response(json_response) do
    case json_response do
      %{"data" => data} -> {:ok, data}
      %{"message" => message} -> {:error, message}
      %{"errors" => errors} -> {:error, errors}
    end
  end
end
