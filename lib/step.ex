defmodule Step do
    alias __MODULE__
  
    @derive [Poison.Encoder]
    defstruct duration: 0, name: "", temperature: 0
    
    def new(name, duration, temperature)  do
      {:ok, %Step{name: name, duration: duration, temperature: temperature}}
    end
  
    #def new(_name, _duration, _temperature), do: {:error, :incomplete_data}
  end