defmodule Cgol do
  @grid [
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
    [0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
    [0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
    [0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
    [0, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
  ]

  def life(grid \\ @grid) do
    grid = 
      grid
      |> gen
      |> display

    :timer.sleep(500)

    life(grid)
  end

  def gen(grid \\ @grid) do
    for i <- 0..19, j <- 0..19 do
      cell = elem_at(grid, i, j)
      n_count = neighbours(grid, i, j) |> length

      next_cell(cell, n_count)
    end
    |> Enum.chunk_every(20)
  end

  def next_cell(1, n) when n < 2, do: 0
  def next_cell(1, n) when n in 2..3, do: 1
  def next_cell(1, n) when n > 3, do: 0
  def next_cell(0, 3), do: 1
  def next_cell(0, _), do: 0

  def elem_at(grid, i, j) do
    grid
    |> Enum.at(i, 0)
    |> Enum.at(j, 0)
  end

  def neighbours(grid, i, j) do
    for k <- (i - 1)..(i + 1),
        l <- (j - 1)..(j + 1),
        {k, l} != {i, j},
        k >= 0,
        l >= 0,
        k < 20,
        l < 20,
        elem_at(grid, k, l) > 0,
        do: {k, l}
  end

  def display(grid) do
    IO.ANSI.clear |> IO.puts
    grid
    |> Enum.each(fn row ->
      row
      |> Enum.each(fn cell ->
        cond do
          cell == 0 -> IO.write("#{IO.ANSI.blue_background()} #{IO.ANSI.reset()}")
          cell > 0 -> IO.write("#{IO.ANSI.yellow_background()} #{IO.ANSI.reset()}")
        end
      end)
      IO.puts("")
    end)

    grid
  end
end
