# myenv

Personal settings for various environments including dotfiles or bootstrap scripts.

# Usage

```bash
mkdir -p ~/my/repo
git clone git@github.com:key-amb/myenv.git ~/my/repo/myenv
cd ~/my/repo/myenv
git submodule update --init

# Set up an environment
MYENV=<target env> script/setup-env.sh
```

See also `envs/<target env>/README.md` if found.
