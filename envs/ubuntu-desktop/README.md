# ubuntu-desktop

# How to set up enviroment

```bash
cd ~/my/repos/myenv
export MYENV=ubuntu-desktop

script/setup-env.sh
envs/$MYENV/script/install-extra-pkgs.sh

script/setup-plenv.sh
script/setup-rbenv.sh

envs/$MYENV/script/setup-docker.sh
```
