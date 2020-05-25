# myenv

Personal settings for various environments including dotfiles or bootstrap scripts.

# Usage

```bash
# (1) As login user

mkdir -p ~/my/repos
git clone git@github.com:progrhyme/myenv.git ~/my/repo/myenv
cd ~/my/repos/myenv
git submodule update --init

# Create admin user
script/create-admin-user.sh $ADMIN
sudo su - $ADMIN

# (2) As admin user
mkdir -p ~/my/repos
git clone git@github.com:progrhyme/myenv.git ~/my/repos/myenv
cd ~/my/repos/myenv
git submodule update --init

# Set up an environment
MYENV=${target_env} script/setup-env.sh
MYENV=${target_env} SETUP_SHELL=${admin_shell} script/setup-shellenv.sh
exit

# (3) As login user
MYENV=${target_env} script/setup-shellenv.sh
exec $SHELL -l
```

See also `envs/${target_env}/README.md` if found.

# Dependencies

This project depends on [progrhyme/dotfiles](https://github.com/progrhyme/dotfiles).

Some scripts suppose it is checked out to the path specified by `$DOTFILES`.
