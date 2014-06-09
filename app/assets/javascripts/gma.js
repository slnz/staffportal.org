$(document).ready(function() {
  if ( controller == "staff/gma_organizations" ) {
    $('iframe').hide();
    $('#gma_organizations a').click(function (e) {
      change_iframe_src('#gma_staff_reports', $(this).attr('href'), '#gma_staff_report_select');
      $('#gma_measurement_select').show();
      parent.change_iframe_src('#gma_measurements', 'about:blank');
      $('#gma_measurements').hide();
      $('#gma_organizations a.active').removeClass('active');
      $(this).addClass('active');
      return false;
    });
  }

  if ( controller == "staff/gma_staff_reports" && action == "index" ) {
    parent.resize_iframe('#gma_staff_reports');
    $('.list-group a').click(function (e) {
      parent.change_iframe_src('#gma_measurements', $(this).attr('href'), '#gma_measurement_select');
      $('.list-group a.active').removeClass('active');
      $(this).addClass('active');
      return false;
    });
  }

  if ( controller == "staff/gma_staff_reports" && action == "edit" ) {
    $('.info').hide();
    parent.resize_iframe('#gma_measurements');
    $('input[type=text]').focus(function() {
      $(this).parent().removeClass('closed');
      $(this).parent().parent().next().slideDown();
    }).blur(function() {
      $(this).parent().addClass('closed');
      $(this).parent().parent().next().slideUp();
    });

    $('.graph').each(function() {
      $(this).highcharts({
        chart: {
            type: 'column'
        },
        legend: {
            enabled: false
        },
        exporting: {
            enabled: false
        },
        tooltip: {
            enabled: false
        },
        credits: {
            enabled: false
        },
        plotOptions: {
            column: {
                animation: false,
                color: '#f8f8f8',
                pointPadding: -0.3,
                states: {
                    hover: {
                        enabled: false
                    }
                }
            }
        },
        series: [{
            data: $(this).data('history')
        }],
        yAxis: {
            gridLineWidth: 0,
            labels: {
                enabled: false
            },
            title: {
                enabled: false
            }
        },
        xAxis: {
            lineWidth: 0,
            tickWidth: 0,
            labels: {
                enabled: false
            },
            title: {
                enabled: false
            }
        },
        title:{
            text:''
        }
      });
    });
    $('.form-wrapper').addClass('closed');
    $('input[type=text]').first().focus();
  }

  if ( controller == "staff/gma_staff_reports" && action == "update" ) {
    parent.resize_iframe('#gma_measurements', $('body').height() + 50);
    $('body').hide().fadeIn();
  }
});

function resize_iframe(iframe) {
  var height = $('.content').height() - 160;
  $(iframe).css('height', height + 'px');
}

function change_iframe_src(iframe, src, notification) {
  $(iframe).show().attr('src', src);
  $(notification).hide();
}