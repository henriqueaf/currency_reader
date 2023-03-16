defmodule CurrencyReader.Storages.LastConversions do
  use Agent

  @list_size_limit 10

  def start_link(initial_value \\ []) do
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def list do
    Agent.get(__MODULE__, & &1)
  end

  def push(conversion) do
    Agent.update(__MODULE__, fn (state) ->
      [conversion | state]
      |> trunc_state()
    end)
  end

  defp trunc_state(state) when length(state) > @list_size_limit do
    state
    |> Enum.slice(0..(@list_size_limit - 1))
  end
  defp trunc_state(state), do: state
end
