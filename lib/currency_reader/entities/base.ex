defmodule CurrencyReader.Entities.Base do
  import Ecto.Changeset, only: [traverse_errors: 2]

  def translate_errors(changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end
end
