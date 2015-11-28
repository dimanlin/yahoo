@drawChart = ->
  $('#chart_div').data('graph')
  data = google.visualization.arrayToDataTable($('#chart_div').data('graph'), true)
#  options =
#    hAxis:
#      title: 'Time',
#    vAxis:
#      title: 'Popularity'
  chart = new (google.visualization.LineChart)(document.getElementById('chart_div'))
  chart.draw data