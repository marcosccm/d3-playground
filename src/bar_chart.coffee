$ ->
  data = [
    { year: 2005, count: 60 },
    { year: 2006, count: 150 },
    { year: 2007, count: 90 },
    { year: 2008, count: 40 },
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
  
  d3.select('svg')
    .selectAll('text')
    .data(data)
    .enter()
    .append('svg:text')
    .attr('x', (d, index) -> x(index) + (barWidth / 2))
    .attr('y', (d, index) -> maxHeight - y(d.count))
    .attr('dy', '1.2em')
    .attr('text-anchor', 'middle')
    .text((d) -> d.count)
    .attr('fill','white')

  d3.select('svg')
    .selectAll('text.yAxis')
    .data(data)
    .enter()
    .append("svg:text")
    .attr("x", (d, index) -> x(index) + (barWidth / 2))
    .attr("y", maxHeight)
    .attr("text-anchor", "middle")
    .text((d) -> d.year)
    .attr("transform", "translate(0, 18)")
    .attr("class", "yAxis")

