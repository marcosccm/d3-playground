$ ->
  data = [
    { year: 2009, count: 50 },
    { year: 2010, count: 120 },
    { year: 2011, count: 70 },
    { year: 2012, count: 140 }
  ]
  
  barWidth  = 40
  maxWidth  = (barWidth + 10) * data.length
  maxHeight = 250

  maxCount = d3.max(data, (d) -> d.count)

  x =  d3.scale.linear().domain([0, data.length]).range([0, maxWidth])
  y =  d3.scale.linear().domain([0, maxCount]).rangeRound([0, maxHeight])

  d3.select('svg')
    .selectAll('rect')
    .data(data)
    .enter()
    .append('svg:rect')
    .attr('x', (d, index) -> x(index))
    .attr('y', (d, index) -> maxHeight - y(d.count))
    .attr('width', barWidth)
    .attr('height', (d) -> y(d.count))
    .attr('fill','#0C5682')

  

