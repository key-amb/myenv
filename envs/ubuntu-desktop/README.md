# ubuntu-desktop

# How to set up enviroment

```bash
cd ~/my/repos/myenv
export MYENV=ubuntu-desktop

# Run by admin user
script/setup-env.sh
envs/$MYENV/script/install-extra-pkgs.sh

envs/$MYENV/script/setup-docker.sh

# Common set-up tasks
script/setup-plenv.sh
script/setup-rbenv.sh
```
