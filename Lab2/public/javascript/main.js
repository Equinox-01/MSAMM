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
      scales : {
        yAxes : [{
            ticks : {
                beginAtZero : true
            }   
        }]
      },
      legend: {
        display: false
      },
      title: {
        display: true
      }
    }
  });
}

function renderUniformDistributions(container){
  container.innerHTML += '<label for="a">a</label><input type="number" class="form-control" name="a"><br>';
  container.innerHTML += '<label for="b">b</label><input type="number" class="form-control" name="b"><br>';
}
function renderGaussianDistributions(container){
  container.innerHTML += '<label for="mean">Математическое ожидание</label><input type="number" class="form-control" name="mean"><br>';
  container.innerHTML += '<label for="scale">Среднеквадратическое отклонение</label><input type="number" class="form-control" name="scale"><br>';
}
function renderExponentialDistributions(container){
  container.innerHTML += '<label for="rate">Интенсивность</label><input type="number" class="form-control" name="rate"><br>';
}
function renderGammaDistributions(container){
  container.innerHTML += '<label for="shape">k</label><input type="number" class="form-control" name="shape"><br>';
  container.innerHTML += '<label for="scale">θ</label><input type="number" class="form-control" name="scale"><br>';
}
function renderTriangleDistributions(container){
  container.innerHTML += '<label for="a">a</label><input type="number" class="form-control" name="a"><br>';
  container.innerHTML += '<label for="b">b</label><input type="number" class="form-control" name="b"><br>';
}
function renderSimpsonDistributions(container){
  container.innerHTML += '<label for="a">a</label><input type="number" class="form-control" name="a"><br>';
  container.innerHTML += '<label for="b">b</label><input type="number" class="form-control" name="b"><br>';
}

function renderDistributions(container, distributions_type) {
    container.innerHTML = "";
    switch(distributions_type) {
      case 'uniform':
        renderUniformDistributions(container);
      break;
      case 'gaussian':
        renderGaussianDistributions(container);
      break;
      case 'exponential':
        renderExponentialDistributions(container);
      break;
      case 'gamma':
        renderGammaDistributions(container);
      break;
      case 'triangle':
        renderTriangleDistributions(container);
      break;
      case 'simpson':
        renderSimpsonDistributions(container);
      break;
    }
}

function switchParams() {

  selector = document.getElementsByClassName('form-control')[0];
  container = document.getElementById('params-input');
  distributions_type = selector.options[selector.selectedIndex].value;

  renderDistributions(container, distributions_type)
}
