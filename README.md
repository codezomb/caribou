### Caribou Vehicles Depreciation

#### Requirements

Create a Ruby on Rails application for setting, storing, and displaying vehicle valuations.

For the sake of this exercise, assume that vehicle valuations are defined as follows:

    A year, make, & model combined are a unique identifier for a vehicle
    Vehicles have an msrp value in dollars for the year it was made
    A valuation is the calculated value of the vehicle today
    valuations are calculated from the msrp as follows:
        Vehicles lose $2,000 immediately after they’re driven off the lot (purchased)
        Vehicles lose $1,000/year for the first 5 years.
        Vehicles lose $500/year after they are 6 years old.
        A Vehicle’s minimum value is $300 (i.e. scrap value).

The application needs to have the following:

    A JSON API endpoint used to set the msrp for a vehicle.
    A JSON API endpoint to retrieve vehicles’ msrp and valuation, given year, make, & model.
    A dashboard for viewing a list of all vehicles, including both their msrp and valuation

#### Quickstart

To start the application, run `docker compose up -d --build`. This will download the dependencies, build the docker container, and launch the application. Once the application is running, type `docker compose ps` and you should see the following:

```shell
NAME                 IMAGE                                       COMMAND                  SERVICE    CREATED       STATUS          PORTS
caribou-app-1        caribou-app                                 "/work/bin/entrypoin…"   app        1 minute ago   Up 1 minute
caribou-postgres-1   public.ecr.aws/docker/library/postgres:14   "docker-entrypoint.s…"   postgres   1 minute ago   Up 1 minute    5432/tcp
caribou-vite-1       caribou-app                                 "/work/bin/entrypoin…"   vite       1 minute ago   Up 1 minute1   0.0.0.0:3036->3036/tcp
caribou-web-1        caribou-app                                 "/work/bin/entrypoin…"   web        1 minute ago   Up 1 minute1   0.0.0.0:80->80/tcp
```

If you have the above 4 containers running, everything should be good to go to setup the data. Run the following to create the database and seed ~ 18 vehicles:

```shell
docker compose exec app rails db:setup
```

Some other useful commands:

```shell
docker compose exec app rm -fsv # tear down the environment
docker compose exec app rails c # get into a rails console
docker compose exec app rspec   # run all of the rspec tests
docker compose exec app bash    # get a shell into the app
```

#### Dashboard

To see the dashboard visit `http://localhost:3000`, you should be greeted with a list of 18 vehicles, their msrp, valuation, and depreciation value (I added the last one as it seemed helpful).

#### API

The API docs are located at `http://localhost:3000/api-docs`. You can use the "Try it out" interface there if you like to view the API responses and details.

#### Notes

- The depreciation logic is located in `lib/depreciation.rb`, and the valuation calculation is in `models/vehicle.rb`. I may have overengineered this, but I had fun and wanted to allow for expansion.
- The IDs are case sensitive. So, `2022_lincoln_mks` is not equivalent to `2022_Lincoln_MKS`.
- Controller logic is handled by my own gem [ImplicitResource](https://github.com/codezomb/implicit_resource).
