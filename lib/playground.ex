defmodule Playground do
  @moduledoc """
  Documentation for `Playground`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Playground.hello()
      :world

  """
  def hello do
    :world
  end

  def init(filename) do
    read_json(filename)
    |> extract_steps
    |> create_steps
  end

  def extract_steps(profile) do
    steps = elem(profile, 1)
    steps["steps"]
  end

  def create_steps(steps) do
    Enum.map(steps, fn (step) -> Step.new(step["name"], step["duration"], step["temperature"]) end)
    |> Enum.map(&(elem(&1, 1))) # handle error
  end

  def read_json(filename) do
    with {:ok, body} <- File.read(filename),
         {:ok, json} <- Poison.decode(body), do: {:ok, json}
  end
end
