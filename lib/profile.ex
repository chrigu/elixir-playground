defmodule Profile do
    alias __MODULE__
  
    @derive [Poison.Encoder]
    @enforce_keys [:name, :steps]
    defstruct [:name, :steps]

    def new(name, steps)  do
      {:ok, %Profile{name: name, steps: steps}}
    end
  
  end