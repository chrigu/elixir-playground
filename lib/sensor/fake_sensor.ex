defmodule Sensor.FakeSensorServer do

    @name :sensor_server
    @refresh_interval :timer.seconds(10) #:timer.minutes(5)
  
    use GenServer

    defmodule State do
        defstruct temperature: 25, heating: true
      end
  
    # Client Interface
  
    def start do
      GenServer.start(__MODULE__, %State{}, name: @name)
    end
  
    def get_sensor_data do
      GenServer.call @name, :get_sensor_data
    end
  
    # Server Callbacks
  
    def init(state) do
      schedule_refresh()
      {:ok, state}
    end
  
    def handle_info(message, state) do
        IO.puts "Can't touch this! #{inspect message}"
        {:noreply, state}
    end
  
    defp schedule_refresh do
      Process.send_after(self(), :refresh, @refresh_interval)    
    end
  
    def handle_call(:get_sensor_data, _from, state) do
        IO.inspect state
        new_state = calculate_new_data(state)
        schedule_refresh()
        {:noreply, new_state}
    end
  
    defp calculate_new_data(%State{heating: true} = state) do
    cond do
        state.temperature <= 30 -> %{state | temperature: state.temperature + 0.5}
        true -> %{state | heating: false}
        end
    end
  end
  