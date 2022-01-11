<template>
  <div class="app">
     <apexcharts width="800" type="scatter" :options="chartOptions" :series="series"></apexcharts>
    <div>
      <button @click="updateChart">Update!</button>
  </div>
  </div>

</template>

<script>
import VueApexCharts from 'vue-apexcharts';
import axios from 'axios';

export default {
  name: 'Chart',
  components: {
    apexcharts: VueApexCharts,
  },
  data() {
    return {
      brains: [0],
      series: [{
        name: 'TEAM 1',
        data: this.generateDayWiseTimeSeries(new Date('11 Feb 2017 GMT').getTime(), 20, {
          min: 10,
          max: 60,
        }),
      },
      {
        name: 'TEAM 2',
        data: this.generateDayWiseTimeSeries(new Date('11 Feb 2017 GMT').getTime(), 20, {
          min: 10,
          max: 60,
        }),
      },
      ],
      chartOptions: {
        chart: {
          height: 400,
          type: 'scatter',
          zoom: {
            type: 'xy',
          },
        },
        dataLabels: {
          enabled: false,
        },
        grid: {
          xaxis: {
            lines: {
              show: true,
            },
          },
          yaxis: {
            lines: {
              show: true,
            },
          },
        },
        xaxis: {
          type: 'datetime',
        },
        yaxis: {
          max: 1000,
        },
      },
    };
  },
  methods: {

    // eslint-disable-next-line no-unused-vars
    convertBrainsToSeries() {
      const series = [];
      // eslint-disable-next-line no-unused-vars,no-return-assign
      this.brains.forEach((element) => {
        const x = new Date(element[2]).getTime();
        const y = element[1];
        series.push([x, y]);
      });
      return series;
    },

    generateDayWiseTimeSeries(baseval, count, yrange) {
      let i = 0;
      const series = [];
      while (i < count) {
        const x = baseval;
        const y = Math.floor(Math.random() * (yrange.max - yrange.min + 1)) + yrange.min;
        // These are time and value
        series.push([x, y]);
        // eslint-disable-next-line no-param-reassign
        baseval += 86400000;
        i += 1;
      }
      return series;
    },
    getSessions() {
      const path = 'http://localhost:5000/brains';
      axios.get(path)
        .then((res) => {
          // this.brains = res.data;
          this.brains = res.data;
          console.log('BRAINS', JSON.stringify(this.brains));
          console.log('BRAIN 0: ', this.brains[0]);
          this.updateChart();
          // Update Chart?
        })
        .catch((error) => {
          // eslint-disable-next-line
          console.error(error);
        });
    },

    updateChart() {
      // const max = 90;
      // const min = 20;
      // eslint-disable-next-line max-len
      // const newData = this.series[0].data.map(() => Math.floor(Math.random() * (max - min + 1)) + min)
      this.series = [
        {
          name: 'TEAM BRAINS',
          data: this.convertBrainsToSeries(),
        },
      ];
    },
  },
  created() {
    this.getSessions();
  },
};
</script>
<style scoped>
  button {
    background: #26E6A4;
    border: 0;
    font-size: 16px;
    padding: 10px;
    margin-left: 28px;
  }
</style>
