defmodule ControllerTest do
    use ExUnit.Case
    doctest Playground

    def create_steps(steps) do
      Enum.map(1..steps , fn(_x) ->
        %Step{}
      end)
    end

    def create_profile_with_steps(steps) do
      steps
      |> create_steps
      |> (&(%Profile{name: "", steps: &1})).()
    end

    def create_controller_with_steps(steps, step_index \\ 0) do
      profile = create_profile_with_steps(steps)
      %Controller{profile: profile, current_step_index: step_index}
    end

    def test_index(controller_data, status, index) do
      assert elem(controller_data, 1).current_step_index == index
      assert elem(controller_data, 0) == status
    end
  
    test "increments step index" do
      create_controller_with_steps(3, 1)
      |> Controller.next_step
      |> (&(test_index(&1, :ok, 2))).()
    end

    test "does not increment step when at highest index" do
      create_controller_with_steps(3, 2)
      |> Controller.next_step
      |> (&(test_index(&1, :max_index, 2))).()
    end

    test "decrements step index" do
      create_controller_with_steps(3, 1)
      |> Controller.previous_step
      |> (&(test_index(&1, :ok, 0))).()
    end

    test "does not decrement step index for first step" do
      controller_data = create_controller_with_steps(3, 0)
      |> Controller.previous_step
      |> (&(test_index(&1, :min_index, 0))).()
    end
  end
  