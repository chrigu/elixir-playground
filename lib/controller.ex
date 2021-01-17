defmodule Controller do
    alias __MODULE__
  
    defstruct profile: nil, current_step_index: 0

    def new(%Profile{} = profile)  do
      {:ok, %Controller{profile: profile}}
    end

    def next_step(%Controller{} = controller) do
      l = length(controller.profile.steps) -1
      case controller.current_step_index do
          ^l -> {:max_index, controller}
          _ -> {:ok, %{ controller | current_step_index: controller.current_step_index + 1 }}
        end
    end

    def previous_step(%Controller{} = controller) do
      case controller.current_step_index do
          0 -> {:min_index, controller}
          _ -> {:ok, %{ controller | current_step_index: controller.current_step_index - 1 }}
        end
    end
  
  end