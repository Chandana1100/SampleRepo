heroku pipelines:destroy samplerepo20190613-pipeline
heroku apps:destroy -a samplerepo20190613-dev -c samplerepo20190613-dev
heroku apps:destroy -a samplerepo20190613-staging -c samplerepo20190613-staging
heroku apps:destroy -a samplerepo20190613-prod -c samplerepo20190613-prod
rm -- "destroysamplerepo20190613.sh"
