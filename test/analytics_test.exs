defmodule CustomerGql.AnalyticsTest do
  use ExUnit.Case, async: true

  setup do
    events = [:create_user, :update_user, :get_user, :users, :update_user_preferences]
    {:ok, pid} = CustomerGql.Analytics.start_link(events, name: nil)
    %{pid: pid}
  end

  describe "register_hit/1" do
    test "returns :ok on successful register_hit", %{pid: pid} do
      assert true === Process.alive?(pid)
      assert :ok === CustomerGql.Analytics.register_hit(:create_user, pid)
    end
  end

  describe "&get_event_counter/1" do
    test "updates event counter by 1", %{pid: pid} do
      CustomerGql.Analytics.register_hit(:create_user, pid)
      assert CustomerGql.Analytics.get_event_counter(:create_user, pid) === 1
      CustomerGql.Analytics.register_hit(:create_user, pid)
      assert CustomerGql.Analytics.get_event_counter(:create_user, pid) === 2
    end

    test "returns nil for unkown event", %{pid: pid} do
      assert CustomerGql.Analytics.get_event_counter(:create_use, pid) === nil
    end
  end
end
