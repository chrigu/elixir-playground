defmodule Sensor.SensorServer do
  
    use GenServer
  
    # Client Interface
  
    def start(caller, name, refresh_interval, sensor_init, sensor_get_reading) do
      GenServer.start(__MODULE__, %{
        caller: caller,
        data: 0,
        name: name,
        refresh_interval: refresh_interval,
        sensor_init_fn: sensor_init,
        sensor_get_reading: sensor_get_reading,
        sensor_state: %{}
      }, name: name)
    end
  
    def get_sensor_data do
      GenServer.call @name, :get_sensor_data
    end
  
    # Server Callbacks
  
    def init(state) do
      sensor_state = state.sensor_init_fn.()
      new_data = run_tasks_to_get_sensor_data(state, sensor_state)
      initial_state = %{state | data: new_data, sensor_state: sensor_state}
      schedule_refresh(state.refresh_interval)
      {:ok, initial_state}
    end
  
    def handle_info(:refresh, state) do
      IO.puts "Refreshing the cache..."
      new_state = state
      |> Map.replace(:data, run_tasks_to_get_sensor_data(state, state.sensor_state))

      send(new_state.caller, {:sensor, new_state.data, new_state.name})
      schedule_refresh(state.refresh_interval)
      {:noreply, new_state}
    end
  
    defp schedule_refresh(refresh_interval) do
      Process.send_after(self(), :refresh, refresh_interval)
    end
  
    def handle_call(:get_sensor_data, _from, state) do
      {:reply, state, state}
    end
  
    defp run_tasks_to_get_sensor_data(state, sensor_state) do
      IO.puts "Running tasks to get sensor data..."

      state.sensor_get_reading.(sensor_state)
    end
  end
  