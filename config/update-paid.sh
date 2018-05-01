#!/bin/bash
### update paid-machine through git
gcloud compute instances start paid
gcloud compute scp ~/PROJECTS/Finmint/config/exclude ali@paid:~/PROJECTS/Finmint/.git/info/exclude
gcloud compute ssh ali@paid << update-paid
cd ~/PROJECTS/Finmint/
git fetch
git reset --hard origin/master
git merge master/origin
git diff --name-only
source .env/bin/activate
cat config/python-requirements.txt | xargs -n 1 pip install
deactivate
update-paid
## turn off the paid machine
gcloud compute instances stop paid
echo paid-machine code files are updated through git

