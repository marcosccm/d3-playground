$ ->
  n = 40
  random = d3.random.normal(0, .2)
  data = d3.range(n).map(random) 

  margin = {top: 10, right: 10, bottom: 20, left: 40}
  width = 960 - margin.left - margin.right
  height = 500 - margin.top - margin.bottom

  x = d3.scale.linear().domain([0, n-1]).range([0, width])
  y = d3.scale.linear().domain([-1, 1]).range([height, 0])

  line = d3.svg.line().x((d,i) -> x(i))
                      .y((d,i) -> y(d))

  svg = d3.select('#container')
          .append('svg')
          .attr('width', width + margin.left + margin.right)
          .attr('height', height + margin.top + margin.bottom)
          .append('g')
          .attr('transform', "translate(#{margin.left},#{margin.top})")

  svg.append('defs')
     .append('clipPath')
     .attr('id', 'clip')
     .append('rect')
     .attr('width', width)
     .attr('height', height)

  svg.append('g')
     .attr('class', 'x axis')
     .attr('transform',"translate(0,#{height})")
     .call(d3.svg.axis().scale(x).orient('bottom'))

  svg.append('g')
     .attr('class', 'y axis')
     .call(d3.svg.axis().scale(y).orient('left'))

  path = svg.append('g').attr('clip-path', 'url(#clip)')
            .append('path')
            .data([data])
            .attr('class', 'line')
            .attr('d', line)

  tick = ->
    data.push(random())
    
    path.attr('d', line)
        .attr('transform', null)
        .transition()
        .duration(1000)
        .ease('linear')
        .attr('transform', "translate(#{x(-1)})")
        .each('end', tick)
    
    data.shift()

  tick()
        
