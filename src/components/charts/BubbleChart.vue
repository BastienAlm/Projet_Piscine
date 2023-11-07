<template>
    <Bubble id="my-chart-id" :options="chartOptions" :data="chartData" />
</template>

<script>
import { Bubble } from 'vue-chartjs';
import * as config from '../event-utils'
import {
    Chart as ChartJS,
    Tooltip,
    Legend,
    PointElement,
    LinearScale
} from 'chart.js';
ChartJS.register(LinearScale, PointElement, Tooltip, Legend)
export default {
    name: 'BubbleChart',
    components: { Bubble },
    data() {
        return {
            chartOptions: {
                responsive: true
            }, 
            labels: [],
            minutes: []
        }
    },
    methods:{
        async getData(){
            const value = await config.workingTimes();
            let datas = value.data.data.map((rep) => rep.start);
            const date = datas.map((rep) => new Date(rep))      
            this.labels = date.map((rep) => config.getMonth(rep));
            this.minutes = date.map((rep) => config.getMinute(rep))
            console.log(this.labels);
        },
        generateRandomColor(){
            return  '#'+(Math.random()*0xFFFFFF<<0).toString(16);
        }

    },
    computed:{
        chartData(){
            this.getData()
            const intialTab = [1,2]
            const chartData = {
                datasets: [
                    {
                        label: 'Data One',
                        backgroundColor: '#f87979',
                        data: [
                            {
                                x: 20,
                                y: 25,
                                r: 5
                            },
                            {
                                x: 40,
                                y: 10,
                                r: 10
                            },
                            {
                                x: 30,
                                y: 22,
                                r: 30
                            }
                        ]
                    },
                ]
            }

            const test = this.labels.map((rep,index) =>{
                return{
                    "label": this.labels[index],
                    "backgroundColor": "##841f22",
                    "data": this.minutes.map((rep, index) => {
                        return {
                            "x":rep,
                            "y":rep,
                            'r':30
                        },
                        {
                            "x":rep,
                            "y":rep,
                            'r':30
                        },
                        {
                            "x":rep,
                            "y":rep,
                            'r':30
                        }
                    }),
                }
            })

            const final = {
                "datasets": test
            } 
            console.log(final);
            return final;
        }
    }
}
</script>

<style>

</style>