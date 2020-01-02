defmodule Eeforty.Processes.EstimatorTest do
  alias Eeforty.Processes.Estimator
  use ExUnit.Case

  @params ["Carpinteria", "Santa Barbara", DateTime.utc_now(), 1_800]

  describe "get_estimate/1" do
    test "with missing parameters" do
      [_h | t] = @params
      incomplete_params = [nil | t]

      {:error, message} = Estimator.get_estimate(incomplete_params)

      assert String.match?(message, ~r/Missing required param/)
    end

    test "with correct parameters" do
      [estimate, commute_time] = Estimator.get_estimate(@params, "success")
      assert is_integer(estimate)
      assert is_integer(commute_time)
    end
  end

  describe "compare_times/1" do
    test "with a larger estimated time" do
      assert Estimator.compare_times([20, 10]) == {:reply, "later", []}
    end

    test "with a smaller estimated time" do
      assert Estimator.compare_times([10, 20]) == {:reply, "now", []}
    end

    test "with an error state" do
      assert Estimator.compare_times({:error, "busted"}) ==
               {:reply, {:error, "busted"}, []}
    end
  end
end
