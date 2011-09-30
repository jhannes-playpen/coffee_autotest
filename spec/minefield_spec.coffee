Minefield = require("../src/minefield").Minefield

    
describe "Minefield", ->
  expectHints = (mines) -> 
    field = new Minefield(mines)
    expect(field.hints())

  it "return zero for field with no neighbouring mine", ->
    expectHints(["...", "...", "..." ]).toEqual([[0,0,0],[0,0,0],[0,0,0]])

  it "should have shape number of rows as minefield", ->
    expectHints(["..."]).toEqual([[0,0,0]])
    
  it "should have shape number of columns as minefield", ->
    expectHints(["..",".."]).toEqual([[0,0],[0,0]])
    
  it "should return mines unchanged", ->
    expectHints(["***","***"]).toEqual([['*','*','*'],['*','*','*']])

  it "should detect neighbouring mines", ->
    expectHints(["...",".*.","..."]).toEqual([[1,1,1], [1,'*',1],[1,1,1]])
  
  it "should count neighbouring mines", ->
    expectHints(["*.*"]).toEqual([['*',2,'*']])
    
  it "should solve complex field", ->
    expectHints(["**.*","....","*.**" ]).
        toEqual([['*','*',2,'*']  ,[3,4,4,3],['*',2,'*','*']])
        
  it "should indicate user knows nothing", ->
    field = new Minefield(["...",".*.","..."])
    board = [[],[],[]]
    field.display (row,column,cell) ->
      board[row][column] = cell
    expect(board).toEqual [["?","?","?"],["?","?","?"],["?","?","?"]]
    
  it "die and display field when revealing mine", ->
    field = new Minefield(["...",".**","..."])
    board = [[],[],[]]
    expect(field.reveal(1, 1)).toEqual(false)
    field.display (row,column,cell) -> board[row][column] = cell
    expect(board[0][1]).toEqual("2")
    expect(board[0][2]).toEqual("2")
    expect(board[1][1]).toEqual("*")
    
  it "should display to html", ->
    field = new Minefield(["..",".."])
    html = field.render_html()
    expect(field.render_row(0)).toEqual('<td data-row="0" data-column="0">?</td><td data-row="0" data-column="1">?</td>')
    expect(html).toEqual('<tr><td data-row="0" data-column="0">?</td><td data-row="0" data-column="1">?</td></tr>' +
       '<tr><td data-row="1" data-column="0">?</td><td data-row="1" data-column="1">?</td></tr>') 
       
  it "should populate with random mines", ->
    field = new Minefield(["."])
    field.set_random_mines 100, 100