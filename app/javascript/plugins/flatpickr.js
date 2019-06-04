import flatpickr from 'flatpickr'
import 'flatpickr/dist/themes/airbnb.css'
import rangePlugin from "flatpickr/dist/plugins/rangePlugin"

    flatpickr("#start_date",{
        altInput:true,
        enableTime: true,
        "plugins": [new rangePlugin({input: "#end_date"})]
    });