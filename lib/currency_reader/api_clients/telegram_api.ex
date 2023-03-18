defmodule CurrencyReader.ApiClients.TelegramApi do
  alias CurrencyReader.ApiClients.{Base}

  use Base

  defp api_url, do: Application.get_env(:currency_reader, :telegram_api_url)
  defp chat_id, do: Application.get_env(:currency_reader, :telegram_api_chat_id)

  def send_message(message) do
    build_url()
    |> make_request(message)
  end

  defp build_url do
    "#{api_url()}sendMessage?chat_id=#{chat_id()}"
  end

  defp make_request(url, message) when is_binary(url) do
    headers = [{'content-type', 'application/json'}]
    content_type = 'application/json'
    body = Jason.encode!(%{text: message})

    IO.puts body
    :httpc.request(:post, {url, headers, content_type, body}, http_request_opts(), [])
  end
end
