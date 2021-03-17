defmodule Sensor.FakeSensor do

    # use struct to check type

    def init() do
        %{name: "FakeSensor", temperature: 25}
    end

    def get_reading(state) do
        calculate_new_data(state)
    end

    def stop do

    end

    defp calculate_new_data(state) do
        cond do
            state.temperature <= 30 -> %{state | temperature: state.temperature + 0.5}
            state.temperature > 30 -> %{state | temperature: state.temperature - 0.5}
        end
    end
end
