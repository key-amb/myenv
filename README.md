# myenv

Personal settings and bootstrap scripts for various environments.

# Prepare

```sh
mkdir -p ~/my/repos

git clone git@github.com:progrhyme/myenv.git ~/my/repos/myenv
cd ~/my/repos/myenv
git submodule update --init
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
exit
```

See also `envs/${target_env}/README.md` if found.

# Related Projects

- [progrhyme/dotfiles](https://github.com/progrhyme/dotfiles)
