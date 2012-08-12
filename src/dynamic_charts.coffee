$ ->
  t = 100000
  v = 70

  next = -> 
    time: ++t
    value: v = ~~Math.max(10, Math.min(90, v + 10 * (Math.random() - .5)))

  data = d3.range(33).map(next)

  setInterval( ->
    data.shift()
    data.push(next())
    redraw()
  , 1500)

  width = 20
  height = 80

  x = d3.scale.linear().domain([0,1]).range([0,width])
  y = d3.scale.linear().domain([0,100]).rangeRound([0,height])

  chart = d3.select('svg')

  chart.selectAll('rect')
       .data(data)
       .enter()
       .append('svg:rect')
       .attr('x', (d,i) -> x(i) - .5) 
       .attr('y', (d) -> height - y(d.value) - .5) 
       .attr('width', width)
       .attr('height', (d) -> y(d.value))
       .attr('fill','#0C5682')
       .attr('stroke','white')

  redraw = ->
    rect  = chart.selectAll('rect').data(data, (d) -> d.time)

    rect.enter()
        .append('svg:rect')
        .attr('x', (d,i) -> x(i + 1) - .5) 
        .attr('y', (d) -> height - y(d.value) - .5) 
        .attr('width', width)
        .attr('height', (d) -> y(d.value))
        .attr('fill','#0C5682')
        .attr('stroke','white')
        .transition().duration(1000)
        .attr('x', (d,i) -> x(i) - .5) 
  
    rect.transition()
        .duration(1000)
        .attr('x', (d,i) -> x(i) - .5) 

    rect.exit()
        .transition()
        .duration(1000)
        .attr('x', (d,i) -> x(i - 1) - .5) 
        .remove()
