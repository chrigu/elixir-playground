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

  @filename "test-profile.json"

  def init() do
    Importer.import(@filename)
    |> Controller.new
    |> elem(1)
  end

end
