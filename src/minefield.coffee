class Minefield
  constructor: (@mines) -> @calculate_hints()
  
  set_random_mines: (height, width) ->
    @mines = []
    for row in [0...height]
      @mines[row] = ((if Math.random() < 0.1 then '*' else '.') for column in [0...width])
    @calculate_hints()
  
  calculate_hints: ->
    @revealed = ([] for row in [0...@mines.length])
    @hintsfield = ([] for row in [0...@mines.length])
    for row in [0...@mines.length]
      @hintsfield[row] = (0 for column in [0...@mines[row].length])

    for row in [0...@mines.length]
      for column in [0...@mines[row].length]
        if @mines[row][column] == '*'
          @hintsfield[row][column] = '*'
          @indicateNeighbour(row-1, column-1)
          @indicateNeighbour(row-1, column)
          @indicateNeighbour(row-1, column+1)
          @indicateNeighbour(row, column+1)
          @indicateNeighbour(row, column-1)
          @indicateNeighbour(row+1, column-1)
          @indicateNeighbour(row+1, column)
          @indicateNeighbour(row+1, column+1)

  indicateNeighbour:(row, column)->
    @hintsfield[row][column] += 1 if 0 <= row < @mines.length && 0 <= column < @mines[row].length && @mines[row][column] != '*'
 
  hints: ->
    @hintsfield
    
  display: (callback) ->
    (callback(x, y, @render_cell_value(x,y))  for x in [0..2] for y in [0..2])

  reveal: (x,y) ->
    @revealed[x][y] = true
    not @gameOver = @mines[x][y] == '*'

  render_html: ->
    ("<tr>#{@render_row(row)}</tr>" for row in [0...@hintsfield.length]).join("")
    
  render_row: (row) ->
    ("""<td data-row="#{row}" data-column="#{column}">#{@render_cell_value(row,column)}</td>""" for column in [0...@hintsfield[row].length]).join("")
  
  render_cell_value: (x,y) ->
    if @gameOver or @revealed[x][y] then @hintsfield[x][y].toString() else "?"

exports ?= {}

exports.Minefield = Minefield

