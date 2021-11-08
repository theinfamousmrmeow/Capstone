<template>
  <div class="app">
     <apexcharts width="800" type="scatter" :options="chartOptions" :series="series"></apexcharts>
    <div>
      <button @click="updateChart">Update!</button>
  </div>

   <table class="table table-hover">
          <thead>
            <tr>
              <th scope="col">Brain</th>
              <th scope="col">Fitness</th>
              <th scope="col">Birthdate</th>
              <th scope="col">Sessions</th>
              <th></th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(brain, index) in brains" :key="index">
              <td>{{ brain[0] }}</td>
              <td>{{ brain[1] }}</td>
              <td>{{ brain[2] }}</td>
              <td>{{ brain[3] }}</td>

<!--              <td>-->
<!--                <span v-if="book.read">Yes</span>-->
<!--                <span v-else>No</span>-->
<!--              </td>-->
              <td>
                <div class="btn-group" role="group">
                  <button type="button"
                          class="btn btn-warning btn-sm"
                          v-b-modal.book-modal
                          @click="onUpdateBook(book)">Update</button>
                  <button
                    type="button"
                    class="btn btn-danger btn-sm"
                    @click="onDeleteBook(book)">
                    Delete
                  </button>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
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
      brains: [],
      series: [{
        name: 'BRAINS',
        data: this.convertBrainsToSeries(new Date('11 Feb 2017 GMT').getTime(), 2, {
          min: 100,
          max: 100,
        }),
      },
      {
        name: 'TEAM 2',
        data: this.generateDayWiseTimeSeries(new Date('11 Feb 2017 GMT').getTime(), 20, {
          min: 10,
          max: 60,
        }),
      },
      {
        name: 'TEAM 3',
        data: this.generateDayWiseTimeSeries(new Date('11 Feb 2017 GMT').getTime(), 30, {
          min: 10,
          max: 60,
        }),
      },
      {
        name: 'TEAM 4',
        data: this.generateDayWiseTimeSeries(new Date('11 Feb 2017 GMT').getTime(), 10, {
          min: 10,
          max: 60,
        }),
      },
      {
        name: 'TEAM 5',
        data: this.generateDayWiseTimeSeries(new Date('11 Feb 2017 GMT').getTime(), 30, {
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
          enabled: true,
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

    convertBrainsToSeries(baseval, count, yrange) {
      let i = 0;
      const series = [];
      // eslint-disable-next-line no-unused-vars
      this.getSessions();
      console.log('HEY THERE', this.brains);
      console.log(this.brains);
      while (i < count) {
        const x = baseval;
        const y = Math.floor(Math.random() * (yrange.max - yrange.min + 1)) + yrange.min;
        series.push([x, y]);
        // eslint-disable-next-line no-param-reassign
        baseval += 86400000;
        i += 1;
      }
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
          this.brains = res.data;
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
      // const newData = this.series[0].data.map(() => Math.floor(Math.random() * (max - min + 1)) + min);
      // In the same way, update the series option
      // this.series = [{
      //   name: 'nonono',
      //   data: newData,
      // }];
      this.getSessions();
    },
  },
  created() {
    this.getSessions();
    console.log(this.brains);
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
