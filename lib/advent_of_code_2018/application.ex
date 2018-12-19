defmodule AdventOfCode2018.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
    ]

    opts = [strategy: :one_for_one, name: AdventOfCode2018.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
