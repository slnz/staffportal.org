$(document).ready(function() {
  if ( controller == "accounts" ) {
    $('tr.expandable').click(function() {
      $(this).toggleClass('closed');
      $(this).next().show().find('td div.bd').slideToggle(200, function () { if (!$(this).is(':visible')) $(this).closest('tr').hide(); });
    });
  }
});

function insert_graph(container, categories, data) {
    $(document).ready(function() {
        chart = new Highcharts.Chart({
            chart: {
                renderTo: container,
                type: 'area',
                height: 200
            },
            title: {
                text: ''
            },
            yAxis: {
                title: {
                    text: ''
                }
            },
            xAxis: {
                categories: categories
            },
            tooltip: {
                formatter: function() {
                    return ''+
                    this.x +': $'+ this.y;
                }
            },
            credits: {
                enabled: false
            },
            series: [{
              name: name,
              data: data
            }],
            legend: {
              enabled: false
            }

        });
    });
}
