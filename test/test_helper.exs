ExUnit.start()

defmodule TestHelper do
  @input_files_path "test/challenge_input/"

  def load_input_from_file(challenge) do
    "#{@input_files_path}#{challenge}.txt"
    |> File.read!()
    |> String.trim()
    |> String.split("\n")
  end
end
