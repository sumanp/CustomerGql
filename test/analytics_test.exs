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
      assert :ok === CustomerGql.Analytics.register_hit(:create_user)
    end
  end

  describe "&get_event_counter/1" do
    test "updates event counter by 1 " do
      assert CustomerGql.Analytics.get_event_counter(:create_user) === 1
      CustomerGql.Analytics.register_hit(:create_user)
      assert CustomerGql.Analytics.get_event_counter(:create_user) === 2
    end

    test "returns nil for unkown event" do
      assert CustomerGql.Analytics.get_event_counter(:create_use) === nil
    end
  end
end
