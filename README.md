# myenv

Personal settings for various environments including dotfiles or bootstrap scripts.

# Prerequisites

- [progrhyme/dotfiles](https://github.com/progrhyme/dotfiles)

# Prepare

```sh
mkdir -p ~/my/repos

git clone git@github.com:progrhyme/dotfiles.git ~/my/repos/dotfiles
cd ~/my/repos/dotfiles
git submodule update --init

git clone git@github.com:progrhyme/myenv.git ~/my/repos/myenv
cd ~/my/repos/myenv
git submodule update --init

export DOTS_ENV=xxx # Choose env in envs/
ln -s ln -s ~/my/repos/myenv/envs/$DOTS_ENV ~/my/repos/dotfiles/envs/$DOTS_ENV
```

# Setup Environment

```bash
# (1) As login user
cd ~/my/repos/myenv
git submodule update --init

## Create admin user
script/create-admin-user.sh $ADMIN
sudo -iu $ADMIN

# --------------------
# (2) As admin user
## Do the same thing to `Prepare` section
mkdir -p ~/my/repos
:

## Set up an environment
export DOTS_ENV=xxx # Ensure
cd ~/my/repos/myenv
script/setup-env.sh
cd ~/my/repos/dotfiles
script/setup-shellenv.sh
exit

# --------------------
# (3) As login user
export DOTS_ENV=xxx # Ensure
cd ~/my/repos/dotfiles
script/setup-shellenv.sh
exec $SHELL -l
```

See also `envs/${target_env}/README.md` if found.