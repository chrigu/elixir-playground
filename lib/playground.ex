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
  @refresh_interval :timer.seconds(5) #:timer.minutes(5)

  def init() do
#    Importer.import(@filename)
#    |> Controller.new
#    |> elem(1)

    {:ok, pid} = Sensor.SensorServer.start(self(), :temp1_sensor, @refresh_interval)
    {:ok, pid} = Sensor.SensorServer.start(self(), :temp2_sensor, :timer.seconds(10))

    listen()
  end

  def listen do
    IO.puts "[#{inspect self}] is listening"
    receive do
      {:sensor, message, from} ->
        IO.puts "[#{inspect self}] Received #{message} from #{inspect from}"
    end
    listen
  end

end
