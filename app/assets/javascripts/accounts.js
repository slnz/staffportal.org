var reload = false;
var graphs = {};
$(document).ready(function() {
  if ( controller == "staff/accounts" ) {
    $('tr.expandable > td > a').click(function() {
      reload = true;
    });
    $('tr.expandable').click(function() {
      if (!reload) {
        $(this).toggleClass('closed');
        var bd = $(this).next().show().find('td div.bd');
        if (graphs[bd.attr('id')] != undefined) graphs[bd.attr('id')].setSize($('.container').width(), 200, false);
        bd.slideToggle(200, function () {
          if ( !$(this).is(':visible') ) {
            $(this).closest('tr').hide();
          }
        });
      }
    });
    $('#summary_currency').change(function() {
      $.get( '/staff/accounts/change_default_currency/' + $(this).children('option:selected').val() + '.json').complete(function(data) {
        window.location.reload(true);
      });
    })
  }
});

$(window).resize(function()
{
    $.each(graphs, function(index, value) {
      value.setSize(
        $('.container').width(),
        200,
        false
      );
    });
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
              type: 'area',
              name: "Goal",
              data: goal,
              color: "#3163d2"
            }, {
              type: 'area',
              name: "Salary",
              data: salary,
              color: "rgb(170,70,67)"
            }, {
              type: 'column',
              name: name,
              data: data,
              color: "#8cdc57"
            }]
    } else {
      var series = [ {
              type: 'area',
              name: "Goal",
              data: goal,
              color: "#3163d2"
            }, {
              type: 'column',
              name: name,
              data: data,
              color: "#8cdc57"
            }]
    }

    $(document).ready(function() {
        graphs[container] = new Highcharts.Chart({
            chart: {
                renderTo: container,
                reflow: false,
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
