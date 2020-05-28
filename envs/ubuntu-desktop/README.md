# ubuntu-desktop

# How to set up enviroment

```bash
# (1) As login user

mkdir -p ~/my/repos
git clone git@github.com:progrhyme/myenv.git ~/my/repos/myenv
cd ~/my/repos/myenv
git submodule update --init

## Prepare dotfiles
git clone git@github.com:progrhyme/dotfiles.git ~/my/repos/dotfiles
cd ~/my/repos/dotfiles
git submodule update --init
ln -s ~/my/repos/myenv/envs/ubuntu-desktop envs/ubuntu-desktop

export MYENV=ubuntu-desktop

## Create admin user
script/create-admin-user.sh $ADMIN
sudo -iu $ADMIN

# ============================================================
# (2) As admin user
mkdir -p ~/my/repos
git clone git@github.com:progrhyme/myenv.git ~/my/repos/myenv
cd ~/my/repos/myenv
git submodule update --init

## Prepare dotfiles
git clone git@github.com:progrhyme/dotfiles.git ~/my/repos/dotfiles
cd ~/my/repos/dotfiles
git submodule update --init
ln -s ~/my/repos/myenv/envs/ubuntu-desktop envs/ubuntu-desktop

export MYENV=ubuntu-desktop

## Set up the environment
cd ~/my/repos/myenv
script/setup-env.sh
envs/$MYENV/script/install-extra-pkgs.sh
envs/$MYENV/script/setup-docker.sh

cd ~/my/repos/dotfiles
SETUP_SHELL=${admin_shell} script/setup-shellenv.sh
exit

# ============================================================
# (3) As login user
export MYENV=ubuntu-desktop
cd ~/my/repos/dotfiles
script/setup-shellenv.sh
exec $SHELL -l
```
