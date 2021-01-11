defmodule Profile do
    alias __MODULE__
  
    @enforce_keys [:row, :col]
    defstruct [:row, :col]
  
  end