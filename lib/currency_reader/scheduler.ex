defmodule CurrencyReader.Scheduler do
  use GenServer

  # ================== CLIENT SIDE ==================
  def start_link(base_currency) do
    # This will call the init() method with base_currency as param
    GenServer.start_link(__MODULE__, base_currency)
  end

  # ================== SERVER SIDE ==================
  @impl GenServer
  def init(base_currency \\ "USD") do
    schedule_process_message(true)
    {:ok, base_currency}
  end

  @impl GenServer
  def handle_info(:convert_currency, base_currency) do
    IO.puts "=============== Converting currency (#{base_currency}) =================="

    CurrencyReader.convert_currency(base_currency)

    schedule_process_message(false)

    {:noreply, base_currency}
  end

  defp schedule_process_message(execute_immediately) do
    execute_in = if execute_immediately, do: 0, else: 1000 * 60 * 60 * 12 # 12h in milliseconds

    Process.send_after(self(), :convert_currency, execute_in)
  end
end
