is_empty_cell = (hints,row,column) ->
  return 0 <= row < hints.length &&
    0 <= column < hints[row].length &&
    hints[row][column] != '*'
    
indicate_neighbouring_mine = (hints,row,column) ->
  hints[row][column]++ if is_empty_cell(hints,row,column)

indicate_neighbouring_mines = (hints,row,column) ->
  indicate_neighbouring_mine(hints,row-1,column-1)
  indicate_neighbouring_mine(hints,row-1,column)
  indicate_neighbouring_mine(hints,row-1,column+1)
  indicate_neighbouring_mine(hints,row,column-1)
  indicate_neighbouring_mine(hints,row,column+1)
  indicate_neighbouring_mine(hints,row+1,column-1)
  indicate_neighbouring_mine(hints,row+1,column)
  indicate_neighbouring_mine(hints,row+1,column+1)

exports.field = (mines)->
  hints = ([] for row in mines)
  for row in [0..mines.length-1]
    hints[row] = (0 for cell in mines[row])
  for row in [0..mines.length-1]
    for column in [0..mines[row].length-1]
      if mines[row][column] == '*'
        indicate_neighbouring_mines(hints,row,column)
        hints[row][column] = "*"
  { hints: hints }