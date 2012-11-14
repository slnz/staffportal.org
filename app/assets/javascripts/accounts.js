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

function insert_graph(container, categories, data, name, goal_input, salary_input) {
    var goal = [0];
    if (goal_input != null)
    {
      goal = [];
      for(var i=0; i<12; i++){
          goal.push(goal_input/12); //Example, pushing 5 integers in an array
      }
    }
    var salary = [0];
    if (salary_input != null)
    {
      salary = [];
      for(var i=0; i<12; i++){
          salary.push(salary_input/12); //Example, pushing 5 integers in an array
      }
      var series = [ {
              name: "Goal",
              data: goal
            }, {
              name: "Salary",
              data: salary
            }, {
              name: name,
              data: data
            }]
    } else {
      var series = [ {
              name: "Goal",
              data: goal
            }, {
              name: name,
              data: data
            }]
    }

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
            series: series,
            legend: {
              enabled: true
            }

        });
    });
}
