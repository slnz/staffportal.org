$(document).ready(function() {
  if ( controller == "accounts" ) {
    $('tr.expandable').click(function() {
      $(this).toggleClass('closed');
      $(this).next().show().find('td div.bd').slideToggle(200, function () { if (!$(this).is(':visible')) $(this).closest('tr').hide(); });
    });
    $('#summary_currency').change(function() {
      $.get( '/staff/accounts/change_default_currency/' + $(this).children('option:selected').val() + '.json').complete(function(data) {
        window.location.reload(true);
      });
    })
  }
});

function insert_graph(container, categories, data, name) {
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
            plotOptions: {
                area: {
                    marker: {
                        enabled: false,
                        symbol: 'circle',
                        radius: 2,
                        states: {
                            hover: {
                                enabled: true
                            }
                        }
                    }
                }
            },
            series:[ /* {
              name: "Goal",
              data: [3500,3500,3500,3500,3500,3500,3500,3500,3500,3500,3500,3500]
            }, {
              name: "Salary",
              data: [2340,2340,2340,2340,2340,2340,2340,2340,2340,2340,2340,2340]
            }, */{
              name: name,
              data: data
            }],
            legend: {
              enabled: true
            }

        });
    });
}
