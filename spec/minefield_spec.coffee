minefield = require '../src/minefield'

hints = (mines)-> minefield.field(mines).hints

describe "Minefield", ->

  it "should display empty minefield", ->
    expect(hints([[null,null,null],[null,null,null],[null,null,null]])).
        toEqual([[0,0,0],[0,0,0],[0,0,0]])
    
  it "should display hints in shape of field", ->
    expect(hints([[null,null,null,null],[null,null,null,null]])).
        toEqual([[0,0,0,0],[0,0,0,0]])
  
  it "should display mines", ->
    expect(hints([['*','*','*'],['*','*','*']])).
        toEqual([['*','*','*'],['*','*','*']])

  it "should display neighbouring mines", ->
    expect(hints([[null,null,null],[null,'*',null],[null,null,null]])).
        toEqual([[1,1,1],[1,'*',1],[1,1,1]])

  it "should count mines", ->
    expect(hints([['*',null,'*']])).toEqual([['*',2,'*']])
