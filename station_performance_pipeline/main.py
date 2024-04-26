"""Main script for data pipeline."""

from datetime import date, timedelta
from os import environ as ENV

import psycopg2
from dotenv import load_dotenv

from extract import (
    fetch_train_services_data_for_station,
)
from load import upload_arrivals, upload_cancellations
from transform import transform_train_services_data

if __name__ == "__main__":
    load_dotenv()

    conn = psycopg2.connect(
        database=ENV["DB_NAME"],
        user=ENV["DB_USER"],
        password=ENV["DB_PASS"],
        host=ENV["DB_HOST"],
        port=ENV["DB_PORT"],
    )

    date = date.today() - timedelta(days=1)

    stations = ["LTN"]

    for station in stations:
        services = fetch_train_services_data_for_station(
            station,
            date,
            username=ENV["REALTIME_API_USER"],
            password=ENV["REALTIME_API_PASS"],
        )

        arrivals, cancellations = transform_train_services_data(services, date)

        upload_arrivals(conn=conn, arrivals=arrivals)
        upload_cancellations(conn=conn, cancellations=cancellations)

    conn.close()
