defmodule CurrencyReader.Entities.Currency do
  use Ecto.Schema
  import Ecto.Changeset
  import CurrencyReader.Entities.Base, only: [translate_errors: 1]

  @required_params [:code]
  @allowed_codes ["BRL", "EUR", "CAD", "USD"]

  embedded_schema do
    field :code, :string
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_params)
    |> validate_inclusion(:code, @allowed_codes)
  end

  def create(code) when is_binary(code) do
    %{code: code}
    |> __MODULE__.changeset
    |> apply_action(:create)
    |> handle_create
  end

  defp handle_create({:ok, currency}), do: currency
  defp handle_create({:error, changeset}) do
    raise ArgumentError, message: "Error creating Currency: #{inspect(translate_errors(changeset))}"
  end
end
