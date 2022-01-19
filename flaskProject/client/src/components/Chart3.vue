<template>
  <div class="app">
     <apexcharts type="treemap" :options="chartOptions" :series="series"></apexcharts>
    <div>
      <button @click="updateChart">Update!</button>
  </div>
  </div>

</template>

<script>
import VueApexCharts from 'vue-apexcharts';
import axios from 'axios';

const WEBAPP_ADDRESS = process.env.VUE_APP_WEBAPP_IP;

export default {
  name: 'Chart3',
  components: {
    apexcharts: VueApexCharts,
  },
  data() {
    return {
      sessions: [0],
      series: [
        {
          data: [
          ],
        },
      ],
      legend: {
        show: true,
      },
      chartOptions: {
        chart: {
          height: 400,
          type: 'treemap',
        },
        dataLabels: {
          enabled: true,
          style: {
            fontSize: '12px',
          },
          formatter(text, op) {
            return [text, op.value];
          },
          offsetY: -4,
        },
        plotOptions: {
          treemap: {
            enableShades: true,
            shadeIntensity: 0.5,
            reverseNegativeShade: true,
            colorScale: {
              ranges: [
                {
                  from: 0,
                  to: 900,
                  color: '#CD363A',
                },
                {
                  from: 901,
                  to: 1000,
                  color: '#52B12C',
                },
              ],
            },
          },
        },
      },
    };
  },
  methods: {

    // eslint-disable-next-line no-unused-vars
    convertSessionsToData() {
      let count = 0;
      let index = 0;
      const clusters = [0, 0, 0, 0, 0];
      const newData = [];
      // eslint-disable-next-line no-unused-vars,no-return-assign
      console.log('SESSIONS', this.sessions);

      this.sessions.forEach((element) => {
        if (count < 1000) {
          // const x = element[1];
          // const y = element[0];
          // newData.push({ x, y });
          const fitness = element[4];
          const cluster = Math.floor(fitness / 200);
          clusters[cluster] += 1;
        }
        count += 1;
      });
      clusters.forEach((item) => {
        if (!Number.isNaN(item)) {
          index += 1;
          const range = (1000 / (clusters.length - 1));
          const x = `F: ${Math.round((index - 1) * range)} - ${Math.round(index * range)}`;
          const y = item;
          newData.push({ x, y });
        }
      });
      //  console.log('Existing Data', this.series[0].data);
      //  console.log('newData map?', newData);
      console.log('CLUSTERS', clusters);
      return newData;
    },
    getSessions() {
      const path = `${WEBAPP_ADDRESS}/sessions`;
      axios.get(path)
        .then((res) => {
          // this.brains = res.data;
          this.sessions = res.data;
          //  console.log('Sessions', JSON.stringify(this.sessions));
          this.updateChart();
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
      this.series[0].data = this.convertSessionsToData();
      // There appears to be a bug in VueApexCharts.
      // Won't update the series unless you update the outermost object.
      // TODO:  Find a workaround, or report a bug?
      const cloneSeries = [];
      Object.assign(cloneSeries, this.series);
      this.series = cloneSeries;
    },
  },
  created() {
    this.getSessions();
    console.log('Existing Data', this.series[0].data);
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
