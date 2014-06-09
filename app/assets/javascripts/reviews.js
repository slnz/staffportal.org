$(document).ready(function() {
  if ( controller == "staff/reviews" && action == "new" ) {
    $('.panel').hide().first().show();
    $('.next').click(function() {
      $(this).closest('.panel').hide().next('.panel').show();
    });
    $('.back').click(function() {
      $(this).closest('.panel').hide().prev('.panel').show();
    });
  }
 if ( controller == "staff/reviews" && action == "index" ) {
  $('#reviews_graph').highcharts({
            chart: {
                type: 'bar'
            },
            title: {
                text: ''
            },
            xAxis: {
                categories: categories,
                title: {
                    text: null
                }
            },
            yAxis: {
                min: 0,
                max: 10,
                minTickInterval: 1,
                title: {
                    text: 'Answer (out of ten)',
                    align: 'high'
                },
                labels: {
                    overflow: 'justify'
                }
            },
            plotOptions: {
                bar: {
                    dataLabels: {
                        enabled: false
                    }
                }
            },
            legend: {
                layout: 'horizontal'
            },
            credits: {
                enabled: false
            },
            series: series
        }) }
});