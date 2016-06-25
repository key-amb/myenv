# myenv

Personal settings for various environments including dotfiles or bootstrap scripts.

# Usage

```bash
# (1) As login user

mkdir -p ~/my/repo
git clone git@github.com:key-amb/myenv.git ~/my/repo/myenv
cd ~/my/repo/myenv
git submodule update --init

# Create admin user
script/create-admin-user.sh $ADMIN
sudo su - $ADMIN

# (2) As admin user
mkdir -p ~/my/repo
git clone git@github.com:key-amb/myenv.git ~/my/repo/myenv
cd ~/my/repo/myenv
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
