# Calendrier de permaculture

[Application web](https://perma-cal.cleverapps.io/) présentant les conseils trouvés sur http://www.terrevivante.org/594-calendrier-des-travaux-du-jardin.htm.

## Installation en local

```
git clone git@github.com:guillaumecabanel/perma_calendar.git
cd perma_calendar
yarn install
bundle install
rails db:create db:migrate db:seed
rails s
```

Le site est disponible sur [localhost:3000](http://localhost:3000)
