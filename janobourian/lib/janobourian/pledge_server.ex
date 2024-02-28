defmodule Janobourian.PledgeServer do

  @name :pledge_server

  def start do
    IO.puts "Starting the pledge server..."

    pid = spawn(__MODULE__, :listen_loop, [[]])
    Process.register(pid, @name)
    pid
  end

  def listen_loop(state) do
    IO.puts "\nWaiting for a message..."

    receive do
      {sender, :create_pledge, name, amount} ->
        {:ok, id} = send_pledge_to_service(name, amount)
        most_recent_pledges = Enum.take(state, 2)
        new_state = [{name, amount} | most_recent_pledges]
        IO.puts "#{name} pledged #{amount}"
        IO.puts "New state is #{inspect new_state}"
        send(sender, {:response, id})
        listen_loop(new_state)
      {sender, :recent_pledges} ->
        send(sender, {:response, state})
        IO.puts "Sent pledges to #{inspect sender}"
        listen_loop(state)
    end
  end

  def create_pledge( name, amount) do
    send(@name, {self(), :create_pledge, name, amount})

    receive do {:response, status} -> status end
  end

  def recent_pledges() do
    send(@name, {self(), :recent_pledges})

    receive do {:response, pledges} -> pledges end
  end

  defp send_pledge_to_service(_name, _amount) do
    # CODE GOES HERE TO SEND PLEDGE TO EXTERNAL SERVICE
    {:ok, "pledge-#{:rand.uniform(1000)}"}
  end
end

# alias Janobourian.PledgeServer

# pid = PledgeServer.start()

# PledgeServer.create_pledge("larry", 10)
# PledgeServer.create_pledge("moe", 20)
# PledgeServer.create_pledge("bae", 30)
# PledgeServer.create_pledge("curly", 40)
# PledgeServer.create_pledge("grace", 50)

# IO.inspect PledgeServer.recent_pledges()
