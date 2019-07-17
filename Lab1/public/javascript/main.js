function getRandomColor() {
  var length = 6;
  var chars = '0123456789ABCDEF';
  var hex = '#';
  while(length--) hex += chars[(Math.random() * 16) | 0];
  return hex;
}

function DrawChart(values_histogram, steps_histogram){
  color_array = []
  for (let i = 1; i < values_histogram.length; i++) {
    color_array.push(getRandomColor());
  }
  return new Chart(document.getElementById("bar-chart"), {
    type: 'bar',
    data: {
      labels: steps_histogram,
      datasets: [
        {
          backgroundColor: color_array,
          data: values_histogram
        }
      ]
    },
    options: {
      legend: {
        display: false
      },
      title: {
        display: true
      }
    }
  });
}