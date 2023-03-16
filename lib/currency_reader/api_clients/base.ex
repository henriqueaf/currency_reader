defmodule CurrencyReader.ApiClients.Base do
  defmacro __using__(_) do
    quote do
      def http_request_opts do
        [
          ssl: [
            verify: :verify_peer,
            cacerts: :public_key.cacerts_get(),
            customize_hostname_check: [
              match_fun: :public_key.pkix_verify_hostname_match_fun(:https)
            ]
          ]
        ]
      end
    end
  end
end
