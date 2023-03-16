defmodule CurrencyReader.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: CurrencyReader.Worker.start_link(arg)
      # {CurrencyReader.Worker, arg}
      %{
        id: CurrencyReader.Scheduler,
        start: {CurrencyReader.Scheduler, :start_link, ["BRL"]},
        restart: :permanent
      },
      {CurrencyReader.Storages.LastConvertions, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: CurrencyReader.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
