defmodule Step do
    alias __MODULE__
  
    @enforce_keys [:duration, :name, :temperature]
    defstruct [:duration, :name, :temperature]
    
    def new(name, duration, temperature)  do
      {:ok, %Step{name: name, duration: duration, temperature: temperature}}
    end
  
    #def new(_name, _duration, _temperature), do: {:error, :incomplete_data}
  end