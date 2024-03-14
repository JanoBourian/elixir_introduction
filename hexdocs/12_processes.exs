pid = spawn(fn -> 1+ 2 end)
IO.puts Process.alive?(pid)
self()
IO.puts Process.alive?(self())

### Sending and receiving messages
send(self(), {:hello, "world"})
receive do
  {:hello, msg} -> msg
  {_, _msg} -> "won't mathc"
end

receive do
  {:hello, msg} -> msg
after
  3_000 -> "nothing after 1 second"
end

parent = self()
spawn(fn -> send(parent, {:hello, self()}) end)
receive do
  {:hello, pid} -> "Got hello from #{inspect pid}"
end
