defmodule CustomerGql.Analytics do
  use GenServer

  @server_name Analytics

  # Client
  def start_link(events, opts \\ []) do
    state = Enum.into(events, %{}, &{&1, 0})
    opts = Keyword.put_new(opts, :name, @server_name)

    GenServer.start_link(CustomerGql.Analytics, state, opts)
  end

  def get_event_counter(event) do
    GenServer.call(@server_name, {:get_event_counter, event})
  end

  def register_hit(event) do
    GenServer.cast(@server_name, {:register_hit, event})
  end

  # Server Callbacks
  def init(state) do
    {:ok, state}
  end

  def handle_call({:get_event_counter, event}, _from_pid, state) do
    {:reply, state[event], state}
  end

  def handle_cast({:register_hit, event}, state) do
    new_state = Map.merge(state, %{event => state[event] + 1})
    {:noreply, new_state}
  end
end
