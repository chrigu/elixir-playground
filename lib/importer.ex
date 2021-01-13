defmodule Importer do
    @moduledoc """
    Documentation for `Playground`.
    """
  
    @doc """
    Hello world.
  
    ## Examples
  
        iex> Playground.hello()
        :world
  
    """
  
    def import(filename) do
      read_json(filename)
      |> elem(1)
      # |> extract_steps
      # |> create_steps
    end
  
    def read_json(filename) do
      with {:ok, body} <- File.read(filename),
           {:ok, json} <- Poison.decode(body, as: %Profile{name: "" ,steps: [%Step{}]}), do: {:ok, json}
    end
  end
  