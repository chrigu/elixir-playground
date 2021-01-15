defmodule Controller do
    alias __MODULE__
  
    defstruct profile: nil, current_step_index: 0

    def new(%Profile{} = profile)  do
      {:ok, %Controller{profile: profile}}
    end

    def next_step(%Controller{} = controller) do
      l = length(controller.profile.steps)
      case controller.current_step_index do
          ^l -> {:error, controller}
          _ -> {:ok, %{ controller | current_step_index: controller.current_step_index + 1 }}
        end
    end

    def previous_step(%Controller{} = controller) do
      case controller.current_step_index do
          0 -> {:error, controller}
          _ -> {:ok, %{ controller | current_step_index: controller.current_step_index - 1 }}
        end
    end
  
  end